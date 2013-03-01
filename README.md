# foreman\_discovery

This plugin aims to enable MaaS hardware discovery in Foreman. It is not ready yet ;)

# Installation:

First, get my Host model refactoring from my [foreman/discovery branch](https://github.com/GregSutcliffe/foreman/tree/discovery_plugin). Get that running.

Then require the gem in Foreman, and also Deface:

    bundler.d/Gemfile.local.rb:
    gem 'deface', '0.7.2'
    gem 'foreman_discovery', :git => "https://github.com/GregSutcliffe/foreman_discovery.git"

Update & Restart Foreman:

    bundle update

# Usage


Boot a machine using the ISO detailed in my [smart-proxy/discovery branch](https://github.com/GregSutcliffe/smart-proxy/tree/discovery). It should register with Foreman and show up on `/discovered`.

Select the Host, view the Facts, click Provision to be taken to a screen where you
can detail the provisioning info.

Delete a machine and reboot it to have it move back to the Discovery Pool.

# Caveats

* Does not have the connection to the proxy to cause a reboot after provisioning,
so you'll have to reboot the machine by hand after the Host has been saved.
* Session information is not being passed correctly in the redirect, so you have to
click "Managed" and fill in most things yourself (including the MAC, annoyingly)
* Various tabs don't work as expected (mainly the Parameters tab)

# TODO

* Fix the caveats
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
