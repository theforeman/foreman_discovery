# foreman\_discovery

This plugin enables MaaS hardware discovery in Foreman. There are two
artifacts (and terms) we will use in this readme:

 * foreman_discovery plugin - image installed in Foreman that adds Provisioned
 Hosts menu entry, API and required configuration
 * discovery image - that needs to be installed and configured with Foreman
 for new (unknown) hosts to boot from over PXE

## Installation

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

You can get the develop branch of the plugin by specifying your Gemfile in this way:

    gem 'foreman_discovery', :git => "https://github.com/theforeman/foreman_discovery.git"

# Building or downloading an image

To build or download discovery image please visit
[ovirt-node-plugin-foreman](https://github.com/theforeman/ovirt-node-plugin-foreman)
page with further information.

On the page, you will find more info how to configure Foreman templates as
well.

# Configuration

## Discovery image

The image is based on CentOS and Fedora and it does leverage oVirt Node
open-source project. The download site provides stable releases as well as
nightly builds for those who want to live on the edge:

 * http://downloads.theforeman.org/discovery/

Nightly builds has ssh daemon enabled and root password set to "redhat" and
logging is increased while releases do have root account locked and there is
no ssh access at all. We provide images based on the following distributions:

 * CentOS 6 (recommended)
 * Fedora 18

### Download via installer

When you boot the image you will noticed that the first console (tty1) is
reserved for Discovery output, if you want to log in use tty2 or higher
console.

Our installer is able to automatically download latest stable CentOS6 images.
For this, re-run the installer with the following option:

    # foreman-installer --foreman-plugin-discovery-install-images=true

You can always download and install manually if you want. See bellow. Once the
image/kernel are downloaded, proceed with template configuration.

### Manual download

Download either both kernel and image RAM disk:

 * ovirt-node-iso-3.X.0-0.999.201404XXXXXX.el6.iso-img
 * ovirt-node-iso-3.X.0-0.999.201404XXXXXX.el6.iso-vmlinuz

or ISO file:

 * ovirt-node-iso-3.X.0-0.999.201404XXXXXX.el6.iso

If you downloaded kernel and image, you can skip to Foreman templates section
bellow. If you downloaded the ISO file, you need to extract it first:

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

Now, copy *vmlinuz0* and *initrd0.img* files to your TFTP BOOT directory and
rename them appropriately.

### Minimal hardware requirements

Since the live image runs from memory, keep in mind the following minimum
requirements on the hardware that is being discovered:

* 700 MB RAM for CentOS6 image
* 900 MB RAM for Fedora19 image

When testing those images on hypervisors, make sure you allocated enough
memory, otherwise kernel panic can be seen during boot sequence.

We are working on decreasing these limits in future releases.

### Foreman templates setup

To activate Foreman Discovery edit *PXELinux global default* template and add
new menu item:

    LABEL discovery
    MENU LABEL Foreman Discovery
    MENU DEFAULT
    KERNEL boot/tftpboot/vmlinuz0
    APPEND rootflags=loop initrd=boot/tftpboot/initrd0.img root=live:/foreman.iso rootfstype=auto ro rd.live.image rd.live.check rd.lvm=0 rootflags=ro crashkernel=128M elevator=deadline max_loop=256 rd.luks=0 rd.md=0 rd.dm=0 nomodeset selinux=0 stateless foreman.url=https://foreman.example.com
    IPAPPEND 2

To set the menu item default, change the above snippet to something like

    DEFAULT menu
    PROMPT 0
    MENU TITLE PXE Menu
    TIMEOUT 200
    TOTALTIMEOUT 6000
    ONTIMEOUT discovery

Note the `foreman.url` that defines where foreman instance really is. You can
use both https or http. Make sure this is set correctly.

Discovery image searches for DNS SRV record named `_x-foreman._tcp`. If you
setup your DNS server for that (example for ISC BIND), then you do not need to
provide `foreman.url` at all:

    _x-foreman._tcp SRV 0 5 443 foreman

This can still be overriden with the command line opts.

It is important to have *IPAPPEND 2* option which adds BOOTIF=MAC option which
is then reported via facter as `discovery_bootif` which is key fact which is
used for provisioning.

_Warning_: For now, you need to provide selinux=0 option, the image is read
only anyway but we plan to enable and test with SELinux too.

## Discovery plugin

No configuration of the Foreman UI is required. If you are using Locations and/or Organisations,
Foreman will default to using the first Location and first Organisation for Discovered
hosts. If you wish to place them in some other Location/Organization, you can alter the
default Loc/Org in `More->Settings->Discovery Settings`

There is also setting called `discovery_fact` which defaults to
`discovery_bootif` which specifies which incoming fact should be used to get
the MAC address. By default PXELinux BOOTIF kernel command line option is used
which gives a MAC address of the interface which was booted from. Make sure
you have set `IPAPPEND 2` option set correctly in the Foreman template.

## Grace Note: Testing

If you only wish to test the plugin code itself, you don't need to create the PXE boot
image above, or have a TFTP server to run it from. Simply POST a hash of Host Facts to
`/fact_values/create?type=Host::Discovered`.The
[script](extra/discover_host#L73)
in my PXE image that does this can be used as an example.

The uploaded hash will appear as a discovered host, and provisioning it should work.

# Usage

Boot a machine using the new PXE config above. It should register with Foreman.
The new Host should show up in `More->Provisioning->Discovered Hosts`. Then select a Discovered Host
and choose Provision. You'll be taken to the normal Edit page for a Host, with the
discovered data filled in where possible. Fill in the details as normal.

On save, a reboot is sent to the discovered host, after which it should reboot into
the installer for the chosen OS, and finally into the installed OS.

Delete a machine and reboot it to have it move back to the Discovery Pool.

# Permissions

The plugin will create a Role called `Discovery` when first started. You can assign
this role to non-admins to allow them to use the discovery plugin. Alternatively
assign the `:perform_discovery` permission to an existing Role.

## Reporting bugs

We use [RedMine
instance](http://projects.theforeman.org/projects/discovery/issues) instead of
github.com issues.

# TODO

* Support for downloading shell script for oVirt Node image
* Add more Tests
* Add API
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
