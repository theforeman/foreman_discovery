# foreman\_discovery

This plugin enables MaaS hardware discovery in Foreman.

# Documentation

The main documentation can be found in the [Foreman Discovery manual](http://theforeman.org/plugins/foreman_discovery/).

## Latest code

If a source-based install of Foreman is in use, the develop
branch of the plugin can be obtained by updating the Gemfile in this way:

    gem 'foreman_discovery', :git => "https://github.com/theforeman/foreman_discovery.git", :branch => 'develop'

# API

see the [API README](README.api.md)

## Reporting bugs

We use [RedMine instance](http://projects.theforeman.org/projects/discovery/issues)
instead of github.com issues. Please report issues there.

## Testing

There are unit and integration tests in the repository, to run them execute the following in the *Foreman core* directory:

	bundle exec rake test:foreman_discovery

It is possible to execute a single test, however the path must be *absolute* (e.g. use `$HOME` variable):

	bundle exec rake test:foreman_discovery TEST=~/work/foreman_discovery/test/unit/host_discovered_test.rb

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
