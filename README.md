# foreman\_discovery

This plugin enables MaaS hardware discovery in Foreman.

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

## Reporting bugs

We use [RedMine
instance](http://projects.theforeman.org/projects/discovery/issues) instead of
github.com issues.

# Building or downloading an image

To build or download discovery image please visit
[ovirt-node-plugin-foreman](https://github.com/theforeman/ovirt-node-plugin-foreman)
page with further information.

On the page, you will find more info how to configure Foreman templates as
well.

# Configuration

## UI config

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
