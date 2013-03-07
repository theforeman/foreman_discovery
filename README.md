# foreman\_discovery

This plugin aims to enable MaaS hardware discovery in Foreman. It is of alpha quality
right now ;)

# Installation:

First, get my Host model refactoring from my [foreman/discovery branch](https://github.com/GregSutcliffe/foreman/tree/discovery_plugin). Get that running.

Then require the gem in Foreman, and also Deface:

    bundler.d/Gemfile.local.rb:
    gem 'deface', '0.7.2'
    gem 'foreman_discovery', :git => "https://github.com/GregSutcliffe/foreman_discovery.git"

Update & Restart Foreman:

    bundle update

## Grace Note: Testing

If you only wish to test the plugin code itself, you don't need to create the ISO below, or
have a TFTP server to run it from. Simply POST a hash of Host Facts to
`/fact_values/create?type=Host::Discovered`.The
[script](https://github.com/GregSutcliffe/smart-proxy/blob/discovery/bin/discover_host#L73)
in my ISO that does this can be used as an example.

The uploaded hash will appear as a discovered host, and provisioning it should work.

# Usage

Boot a machine using the ISO detailed in my [smart-proxy/discovery branch](https://github.com/GregSutcliffe/smart-proxy/blob/discovery/discovery_setup_notes.md). It should register with Foreman and show up on `/discovered`.

Select the Host, view the Facts, click Provision to be taken to a screen where you
can detail the provisioning info.

Delete a machine and reboot it to have it move back to the Discovery Pool.

# Caveats

* Does not have the connection to the proxy to cause a reboot after provisioning,
so you'll have to reboot the machine by hand after the Host has been saved.
* Various dropdowns don't work as expected (mainly the Hostgroup/Environment/Puppet classes)
* The topbar (Dashboard|Hosts|Reports etc) cannot be displayed due to a namespace bug

# TODO

* Fix the caveats
* Get stuff merged up so the foreman/smart-proxy branches are not required
* Add ACLs
* Add Tests
* Add API

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
