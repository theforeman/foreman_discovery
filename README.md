# foreman\_discovery

This plugin enables MaaS hardware discovery in Foreman. There are two
artifacts (and terms) used in this document:

* foreman_discovery plugin - software installed in Foreman that adds Discovered
  Hosts menu entry, API and required configuration
* discovery image - net-bootable image that needs to be installed in the TFTP
  server and configured in Foreman for new (unknown) hosts to boot from over
  PXE

## Minimal hardware requirements

Since the bootable image runs from memory, keep in mind the minimum
requirement of 500 MB RAM otherwise kernel panic can be seen during boot
sequence.

# Installation (plugin)

Please see the Foreman wiki for appropriate instructions:

* [Foreman: How to Install a Plugin](http://projects.theforeman.org/projects/foreman/wiki/How_to_Install_a_Plugin)

The gem name is "foreman_discovery".

RPM users can install the "ruby193-rubygem-foreman_discovery" or
"rubygem-foreman_discovery" packages.

## Compatibility

| Foreman Version | Plugin Version | Image Version       |
| --------------- | --------------:| -------------------:|
| <= 1.2          | 1.0.2          | N/A                 |
|  = 1.3          | 1.1.0          | 0.1.0               |
|  = 1.4          | 1.2.0          | 0.3.0-1             |
|  = 1.5          | 1.3.0          | 0.5.0-1             |
| >= 1.6          | 1.4.0          | 0.6 or 2.0          |

## Latest code

If a source-based install of Foreman is in use, the develop
branch of the plugin can be obtained by updating the Gemfile in this way:

    gem 'foreman_discovery', :git => "https://github.com/theforeman/foreman_discovery.git"

# Installation (image)

The image is based on CentOS 7 and about 150 MB in size. The recommended
option is to download a prebuilt image from the Foreman repositories.

## Downloading an image

### Download via installer

As of Foreman 1.6, the foreman-installer is able to automatically download
latest stable image.  For this, re-run the installer with the following
option:

    # foreman-installer \
        --enable-foreman-plugin-discovery \
        --foreman-plugin-discovery-install-images=true

### Manual download

Images are available from:

* http://downloads.theforeman.org/discovery/

To download the latest release to the expected location, do the following:

    # wget http://downloads.theforeman.org/discovery/releases/latest/fdi-image-latest.tar \
      -O - | tar x --overwrite -C /var/lib/tftpboot/boot

After download, verify checksums:

    # cat /var/lib/tftpboot/boot/fdi-image/SHA256SUM
    beb3cfba7d9fb9d71481c0c8f... initrd0.img
    f03bce150d2473a28697d2988... vmlinuz0
    # sha256sum /var/lib/tftpboot/boot/fdi-image/*

### Building an image

To build a discovery image, please visit the
[foreman-discovery-image](https://github.com/theforeman/foreman-discovery-image)
git repository and find the README for further instructions.

# Configuration (image)

Foreman Discovery relies on intercepting the normal boot process for machines
not registered in Foreman. To achieve this, the PXE default.cfg file needs to
be altered to instruct new machines to boot the discovery image.

In the Foreman UI, go to Provisioning Templates, edit *PXELinux global default*
template and add the following after the "LABEL local" block of options:

    LABEL discovery
    MENU LABEL Foreman Discovery
    MENU DEFAULT
    KERNEL boot/fdi-image/vmlinuz0
    APPEND initrd=boot/fdi-image/initrd0.img rootflags=loop root=live:/fdi.iso rootfstype=auto ro rd.live.image acpi=force rd.luks=0 rd.md=0 rd.dm=0 rd.lvm=0 rd.bootif=0 rd.neednet=0 nomodeset proxy.url=http://xyz proxy.type=proxy
    IPAPPEND 2

Note the `proxy.url` option on the APPEND line, which defines
where the foreman-proxy instance is. This url can receive a proxy url or foreman url
and `proxy.type` defines which one was entered (can be 'foreman' or 'proxy').
If `proxy.type` is not entered the default is to use foreman directly.
Then make this the default by altering the `ONTIMEOUT` option:

    ONTIMEOUT discovery

*Alternatively*, the Discovery image also searches for DNS SRV record named
`_x-foreman._tcp`. If the DNS server is configured for this (see the example
for ISC BIND below), then it is not required to provide `foreman.url` at all.

    _x-foreman._tcp SRV 0 5 443 foreman

This can still be overriden with the command line opts.

It is important to have *IPAPPEND 2* option which adds BOOTIF=MAC option which
is then reported via facter as `discovery_bootif` which is key fact which is
used for provisioning. Without this line, DNS will not work properly as well.

It is important to know that DNS servers from DHCP are enabled only for the
interface that was specified via the BOOTIF option. This means when a system
have multiple NICs, DNS will work for the correct interface - the one that was
booted from.

_Warning_: For now, the selinux=0 option *must* be provided, the image is read
only anyway but we plan to enable and test with SELinux too.

## Updating the on-disk `default` file

Once the template has been updated, click the Build PXE Default button at the top
of the Provisioning Templates page. This will instruct the TFTP proxy to rewrite
the `pxelinux.cfg/default` file.

# Configuration (plugin)

No configuration of the plugin in the Foreman UI is required, but some
configuration is available.

If Locations and/or Organisations are enabled, Foreman will default to using
the first Location and first Organisation for Discovered hosts. If hosts should
be placed in some other Location/Organization, alter the default Loc/Org in
`More->Settings->Discovered`

There is also setting called `discovery_fact` which defaults to
`discovery_bootif` which specifies which incoming fact should be used to get
the MAC address. By default PXELinux BOOTIF kernel command line option is used
which gives a MAC address of the interface which was booted from. Make sure
the `IPAPPEND 2` option is set correctly in the Foreman template.

# Usage

Boot a machine using the new PXE config above. It should register with
Foreman. The new Host should show up in `Hosts->Discovered Hosts`. Then select
a Discovered Host and choose Provision. This will redirect to the normal Edit
page for a Host, with the discovered data filled in where possible. Fill in
the details as normal.

On save, a reboot is sent to the discovered host, after which it should reboot into
the installer for the chosen OS, and finally into the installed OS.

Delete a machine and reboot it to have it move back to the Discovery Pool.

# Permissions

The plugin will create a Role called `Discovery` when first started. This can
be assigned to roles for non-admins to allow them to use the discovery plugin.
Alternatively assign the `:perform_discovery` permission to an existing Role.

# Troubleshooting

If the booted machine fails to register with Foreman, then there are a number of common causes:

* Machine did not boot the correct image
  * check your `pxelinux.cfg/default` has the right config as above
* Machine booted image but failed to contact Foreman
  * Check the `foreman.url` option in `pxelinux.cfg/default` is correctly defined
  * Check DNS is working for that image, or use an IP in `foreman.url`
  * Check DHCP is handing IPs to the booted image correctly

To log in the running image you need to set root password which is locked by
default. In addition, you can enable ssh server as well. To do this, provide
the following kernel command line options:

    APPEND ... fdi.ssh=1 fdi.rootpw=redhat

# API

see the [API README](README.api.md)

## Reporting bugs

We use [RedMine instance](http://projects.theforeman.org/projects/discovery/issues)
instead of github.com issues. Please report issues there.

## Grace Note: Testing

If you only wish to test the plugin code itself, you don't need to create the PXE boot
image above, or have a TFTP server to run it from. Simply POST a hash of Host Facts to
`/api/v2/discovered_hosts/facts` to create a Discovered Host in the UI.

# Copyright

Copyright (c) 2012-2014 Greg Sutcliffe and The Foreman developers

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
