# vim: ts=8:sw=8:noet
#
# Copyright (C) 2013 Red Hat, Inc.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
# MA  02110-1301, USA.  A copy of the GNU General Public License is
# also available at http://www.gnu.org/copyleft/gpl.html.

EXTRA_DIST = *.ks

OVIRT_NODE_RECIPEdir = $(datadir)/ovirt-node-recipe
pluginsdir = $(sysconfdir)/ovirt-plugins.d

OVIRT_NODE_RECIPE_DATA = \
			 foreman-plugin-minimizer.ks \
			 foreman-plugin-iso.ks

dist_plugins_DATA = \
		    foreman-plugin-minimizer.ks

install-data-hook:
	mv $(DESTDIR)/$(pluginsdir)/foreman-plugin-minimizer.ks $(DESTDIR)/$(pluginsdir)/foreman-plugin.minimize
