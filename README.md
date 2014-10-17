# foreman\_discovery

This plugin enables MaaS hardware discovery in Foreman. There are two
artifacts (and terms) used in this document:

* foreman_discovery plugin - software installed in Foreman that adds Discovered
  Hosts menu entry, API and required configuration
* discovery image - net-bootable image that needs to be installed in the TFTP
  server and configured in Foreman for new (unknown) hosts to boot from over
  PXE

## Minimal hardware requirements

Since the bootable image runs from memory, keep in mind the following minimum
requirements on the hardware that is being discovered:

* 700 MB RAM for the CentOS image
* 900 MB RAM for the Fedora image

When testing those images on virtual machines, make sure they have allocated
enough memory, otherwise kernel panic can be seen during boot sequence.

# Installation (plugin)

Please see the Foreman wiki for appropriate instructions:

* [Foreman: How to Install a Plugin](http://projects.theforeman.org/projects/foreman/wiki/How_to_Install_a_Plugin)

The gem name is "foreman_discovery".

RPM users can install the "ruby193-rubygem-foreman_discovery" or
"rubygem-foreman_discovery" packages.

## Compatibility

| Foreman Version | Plugin Version | oVirt Image Version |
| --------------- | --------------:| -------------------:|
| <= 1.2          | 1.0.2          | N/A                 |
|  = 1.3          | 1.1.0          | 0.1.0               |
|  = 1.4          | 1.2.0          | 0.3.0-1             |
| >= 1.5          | 1.3.0          | 0.5.0-1             |

## Latest code

If a source-based install of Foreman is in use, the develop
branch of the plugin can be obtained by updating the Gemfile in this way:

    gem 'foreman_discovery', :git => "https://github.com/theforeman/foreman_discovery.git"

# Installation (image)

The image is based on CentOS 6 & Fedora 18 (there is an image for each) and it
leverages the oVirt Node open-source project. The download site provides stable
releases as well as nightly builds for those who want to live on the edge, or
alternatively a local image can be rebuilt by the user.

The recommended option is to download a prebuilt image from the Foreman
repositories.

Nightly builds have the ssh daemon enabled and root password set to "redhat";
logging is also increased. Conversely, releases have the root account locked
and there is no ssh access. Note that the first console (tty1) is reserved for
Discovery output. For a login prompt (nightly images only) use tty2.

## Downloading an image

### Download via installer

As of Foreman 1.6, the foreman-installer is able to automatically download
latest stable CentOS6 images.  For this, re-run the installer with the
following option:

    # foreman-installer --enable-foreman-plugin-discovery --foreman-plugin-discovery-install-images=true

### Manual download

Images are available from:

* http://downloads.theforeman.org/discovery/

A choice of using an ISO or a kernel/initrd pair is available.

Kernel/initrd (recommended):

* ovirt-node-iso-3.X.0-0.999.201404XXXXXX.el6.iso-img
* ovirt-node-iso-3.X.0-0.999.201404XXXXXX.el6.iso-vmlinuz

or ISO file:

* ovirt-node-iso-3.X.0-0.999.201404XXXXXX.el6.iso

When downloading the ISO file, it must be extracted before proceeding:

    # yum -y install livecd-tools
    # ln -sf ovirt-node-iso-3.X.0-0.999.201404170648.el6.iso foreman.iso
    # sudo livecd-iso-to-pxeboot foreman.iso
    # find tftpboot/
    tftpboot/
    tftpboot/vmlinuz0
    tftpboot/pxelinux.0
    tftpboot/pxelinux.cfg
    tftpboot/pxelinux.cfg/default
    tftpboot/initrd0.img

Once the initrd/vmlinuz pair (whether from direct download or from ISO
extraction) is available, copy them to the TFTP BOOT directory and rename them
to *foreman-discovery-image-latest.el6.iso-vmlinuz* and
*foreman-discovery-image-latest.el6.iso-img*.

    mv tftpboot/vmlinuz0 /var/lib/tftpboot/boot/foreman-discovery-image-latest.el6.iso-vmlinuz
    mv tftpboot/initrd0.img /var/lib/tftpboot/boot/foreman-discovery-image-latest.el6.iso-img

### Building an image

To build a discovery image, please visit the
[ovirt-node-plugin-foreman](https://github.com/theforeman/ovirt-node-plugin-foreman)
page for further instructions.

# Configuration (image)

Foreman Discovery relies on intercepting the normal boot process for machines
not registered in Foreman. To achieve this, the PXE default.cfg file needs to
be altered to instruct new machines to boot the discovery image.

In the Foreman UI, go to Provisioning Templates, edit *PXELinux global default*
template and add:

    LABEL discovery
    MENU LABEL Foreman Discovery
    MENU DEFAULT
    KERNEL boot/foreman-discovery-image-latest.el6.iso-vmlinuz
    APPEND rootflags=loop initrd=boot/foreman-discovery-image-latest.el6.iso-img root=live:/foreman.iso rootfstype=auto ro rd.live.image rd.live.check rd.lvm=0 rootflags=ro crashkernel=128M elevator=deadline max_loop=256 rd.luks=0 rd.md=0 rd.dm=0 rd.bootif=0 rd.neednet=0 nomodeset selinux=0 stateless foreman.url=https://foreman.example.com
    IPAPPEND 2

to the end of the file.  Note the `foreman.url` option on the APPEND line,
which defines where foreman instance is. Make sure this is set correctly or
discovered hosts will not register to Foreman.  Then make this the default by
altering the `ONTIMEOUT` option:

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

An example complete *PXELinux global default* template for Discovery might look
like this:

    DEFAULT menu
    PROMPT 0
    MENU TITLE PXE Menu
    TIMEOUT 200
    TOTALTIMEOUT 6000
    ONTIMEOUT discovery

    LABEL discovery
    MENU LABEL Foreman Discovery
    KERNEL boot/foreman-discovery-image-latest.el6.iso-vmlinuz
    APPEND rootflags=loop initrd=boot/foreman-discovery-image-latest.el6.iso-img root=live:/foreman.iso rootfstype=auto ro rd.live.image rd.live.check rd.lvm=0 rootflags=ro crashkernel=128M elevator=deadline max_loop=256 rd.luks=0 rd.md=0 rd.dm=0 rd.bootif=0 rd.neednet=0 nomodeset selinux=0 stateless foreman.url=https://foreman.example.com
    IPAPPEND 2

# Configuration (plugin)

No configuration of the plugin in the Foreman UI is required, but some
configuration is available.

If Locations and/or Organisations are enabled, Foreman will default to using
the first Location and first Organisation for Discovered hosts. If hosts should
be placed in some other Location/Organization, alter the default Loc/Org in
`More->Settings->Discovery Settings`

There is also setting called `discovery_fact` which defaults to
`discovery_bootif` which specifies which incoming fact should be used to get
the MAC address. By default PXELinux BOOTIF kernel command line option is used
which gives a MAC address of the interface which was booted from. Make sure
the `IPAPPEND 2` option is set correctly in the Foreman template.

# Usage

Boot a machine using the new PXE config above. It should register with Foreman.
The new Host should show up in `More->Provisioning->Discovered Hosts`. Then
select a Discovered Host and choose Provision. This will redirect to the normal
Edit page for a Host, with the discovered data filled in where possible. Fill
in the details as normal.

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

When working with production images (no root password set), it is still
possible to log on as root. Generate some root password:

    $ openssl passwd -salt RH redhat
    RHhwCLrQXB8zE

And then provide it as an kernel command line option:

    APPEND ... rootpw=RHhwCLrQXB8zE

Images with systemd allows interactive mode to be enabled to track down boot
problems. Add the following to the kernel command line option:

    APPEND ... systemd.confirm_spawn=true

By default SSHD daemon is configured to disallow passwords. You can enable
this with:

    APPEND ... ssh_pwauth=1

# API

see the [API README](README.api.md)

## Reporting bugs

We use [RedMine instance](http://projects.theforeman.org/projects/discovery/issues)
instead of github.com issues. Please report issues there.

## Grace Note: Testing

If you only wish to test the plugin code itself, you don't need to create the PXE boot
image above, or have a TFTP server to run it from. Simply POST a hash of Host Facts to
`/api/v2/discovered_hosts/facts` to create a Discovered Host in the UI.

# TODO

* Support for downloading shell script for oVirt Node image
* Add more Tests
* Add proper Location/Organization handling (via a Wizard maybe?)
* Add per-subnet discovery
* Rake Task for ISO build
* Easy way to add custom facts to build/runtime

# Copyright

Copyright (c) 2012-2013 Greg Sutcliffe

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
