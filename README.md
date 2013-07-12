# foreman\_discovery

This plugin aims to enable MaaS hardware discovery in Foreman. It is of alpha quality
right now ;)

# Dependencies

* Foreman >= 1.2.0

# Installation

Require the gem in Foreman.

    bundler.d/Gemfile.local.rb:
    gem 'foreman_discovery'

If you want to use the very latest code, use a git gem:

    gem 'foreman_discovery', :git => "https://github.com/theforeman/foreman_discovery.git"

Update & Restart Foreman:

    bundle update

# Building the Discovery PXE Image

There is a rake task for the discovery image. It requires Ruby 1.8, but should
appropriately detect and use ruby1.8 even if the system default is 1.9. If you
have trouble building it, try a ruby1.8-only system.

Run this in the Foreman app root:

    rake discovery:build_image

You image will be in ./discovery\_image. Run the rake task as root, or with passwordless
sudo, as the password prompts may get lost in the ruby->bash forking process.

# Configuration

## Image configuration

The PXE image has two configuration options during build:

* By default it will have an automatic login to the 'tc' user and start ssh so you can
ssh to `tc@<ip>` with password test1234. By specifying `mode=prod` on the rake task,
you can disable both of these - the image will have no accounts that can be logged in
* If you need to add additional files to the image, put them in `./additional_build_files/` -
these will be copied to `/additional_build_files/` in the image

Also, it will attempt todownload `/discovery_init.sh` from your Foreman server and run
it. This is entirely optional - if the server cannot be reached or the file cannot be
found, the image has a fallback script built in.

You can find an example script [here](extra/discovery_init.sh.example) - place your
modified version in the `public/` directory on your Foreman server.

## PXE config

Configure the PXE default to boot the Discovery Image built above, eg:

    DEFAULT menu
    PROMPT 0
    MENU TITLE PXE Menu
    TIMEOUT 200
    TOTALTIMEOUT 6000
    ONTIMEOUT discovery

    LABEL discovery
    MENU LABEL Boot Discovery
    TEXT HELP
    Boot the Foreman Discovery Image
    Use TAB to edit options for specific needs.
    ENDTEXT
    KERNEL /boot/TinyCore-vmlinuz
    APPEND initrd=/boot/TinyCore-initrd.gz foreman.ip=192.168.122.1:3000

Be sure to alter the foreman.ip appropriately. You can also use foreman.server to
specify a DNS record (`foreman.server=myforemanhost`) but in this case the port will
be assumed to be http (80). If all else fails (say, USB boot where we can't provide
options) it will look for a DNS record of `foreman`

### Known Issues with the image

On some multi-core systems the TinyCore kernel may segfault on boot with an error message similar to :

    "Fixing recursive fault but reboot is needed!"

If this happens, it can be fixed by changing the KERNEL line in the PXE config above to read :

    KERNEL /boot/TinyCore-vmlinuz maxcpus=1

More information on the maxcpus kernel parameter can be found at <https://www.kernel.org/doc/Documentation/kernel-parameters.txt>

A currently unavoidable side effect of this setting is that the initial facts gathered during discovery will only show a single processor, since that is all that is visible to the kernel.

## UI config

No configuration of the Foreman UI is required. If you are using Locations and/or Organisations,
Foreman will default to using the first Location and first Organisation for Discovered
hosts. If you wish to place them in some other Location/Organization, you can alter the
default Loc/Org in `More->Settings->Discovery Settings`

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
