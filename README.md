# foreman\_discovery

This plugin enables MaaS hardware discovery in Foreman. The machine boots from
the network via PXE and loads a special image based on [Tiny Core Linux](http://distro.ibiblio.org/tinycorelinux/) that
talks to Foreman and registers the machine as a Discovered Host. Once the
machine is discovered it can be set up and provisioned just like regular hosts
managed by Foreman.

Please see the [Foreman Discovery Plugin Walkthrough video](http://www.youtube.com/watch?v=52K7gYAR84k)
on YouTube for an introduction and installation walkthrough. 

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
| >= 1.4          | 1.2.0          | 0.3.0-1             |

## Latest code

You can get the develop branch of the plugin by specifying your Gemfile in this way:

    gem 'foreman_discovery', :git => "https://github.com/theforeman/foreman_discovery.git"

## Reporting bugs

We use [RedMine
instance](http://projects.theforeman.org/projects/discovery/issues) instead of
github.com issues.

# Building or downloading an image

There are two options at the moment:

* [Build or download Tiny Core Linux based image](README.tcl_image.md)
* [Build or download oVirt Node based image](README.ovirt_image.md)

The TCL image has the same version as the Foreman Discovery plugin, the oVirt
Node image has different versioning scheme.

# Preparing the DHCP server 

A prerequisite is that the network's DHCP server can serve unknown clients and
that it points those clients to the TFTP server from which they will load the
discovery boot image. This is different from regular Foreman operation, where
there are no unknown clients since Foreman creates leases for to-be-provisioned
hosts beforehand.

## ISC DHCP server

Configure the ISC DHCP server to serve a range of IP addresses and point to the TFTP server:

```
subnet 10.1.7.0 netmask 255.255.255.0 {
    # The range of IP addresses available for clients
    # in this subnet. The dynamic-bootp flag indicates that
    # BOOTP clients as well as DHCP clients will use this
    # range.
	range dynamic-bootp 10.1.7.1 10.1.7.253;
	# This is our TFTP server serving PXE
	next-server 10.1.7.10;
	filename = "pxelinux.0";

	option routers 10.1.7.254;
	option domain-name-servers 10.1.7.42;
	option domain-search "hosts.example.com", "example.com";
}
```

Adjust to your own network settings, obviously.

# Configuration

## UI config

No configuration of the Foreman UI is required. If you are using Locations and/or Organisations,
Foreman will default to using the first Location and first Organisation for Discovered
Hosts. If you wish to place them in some other Location/Organization, you can alter the
default Loc/Org in `More->Settings->Discovery Settings`

## PXE configuation (PXE default file)

Machines to be discovered boot from the network and using PXE will load the
discovery image. But the default PXE configuration Foreman manages only instructs
machines to boot from their local disk, so this needs to be changed.

Go to `More -> Provisioning -> Provisioning Templates` and edit the `PXE Default File` to read:

```
DEFAULT menu
PROMPT 0
MENU TITLE PXE Menu
TIMEOUT 100
TOTALTIMEOUT 6000
ONTIMEOUT discovery

LABEL discovery
    TEXT HELP
    Boot the Foreman Discovery Image
    Use TAB to edit options for specific needs.
    ENDTEXT
    KERNEL /boot/TinyCore-vmlinuz
    APPEND initrd=/boot/TinyCore-initrd.gz foreman.ip=10.1.7.10:3000
```

Make sure `foreman.ip` is set appropriately, including any necessary port. You
can also use `foreman.server` to specify a DNS record
(`foreman.server=foreman.example.com`) but in this case the port will be
assumed to be 80 (HTTP). If all else fails (say, USB boot where we can't
provide options) it will look for a DNS record of `foreman`.

After setting up the `PXE Default File` click `Build PXE Default` to save the
PXE configuration to your TFTP servers.

## Grace Note: Testing

If you only wish to test the plugin code itself, you don't need to create the PXE boot
image above, or have a TFTP server to run it from. Simply POST a hash of Host Facts to
`/fact_values/create?type=Host::Discovered`. The [script](extra/discover_host#L73)
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
