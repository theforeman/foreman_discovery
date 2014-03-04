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

AC_INIT([ovirt-node-plugin-foreman], [0.3.1], [foreman-dev@googlegroups.com])
AM_INIT_AUTOMAKE([-Wall -Werror foreign -Wno-portability tar-pax])
AC_SUBST([ENGINENAME], ['Foreman Discovery'])
PKG_PROG_PKG_CONFIG

AC_MSG_CHECKING([whether to enable plugin debug support])
AC_ARG_ENABLE(debug,
	AS_HELP_STRING([--enable-debug],
		       [turn on debug support (starts ssh daemon and sets root password)]))
if test x$enable_debug = xyes; then
	AC_MSG_RESULT([yes])
	AC_MSG_NOTICE([WARNING: ssh daemon enabled and root password set to 'development'])
	PLUGIN_DEBUG=1
	EXTRA_FIREWALL_RULE="22,tcp"
else
	AC_MSG_RESULT([no])
	PLUGIN_DEBUG=0
	EXTRA_FIREWALL_RULE="#22,tcp"
fi
AC_SUBST(PLUGIN_DEBUG)
AC_SUBST(EXTRA_FIREWALL_RULE)

AC_MSG_CHECKING([for systemd unit directory])
AC_ARG_WITH([systemdsystemunitdir],
	AS_HELP_STRING([--with-systemdsystemunitdir=DIR],
		   [Directory for systemd service files]),
	[], [with_systemdsystemunitdir=$($PKG_CONFIG --variable=systemdsystemunitdir systemd)])
if test "x$with_systemdsystemunitdir" != xno; then
	AC_SUBST([systemdsystemunitdir], [$with_systemdsystemunitdir])
fi
AM_CONDITIONAL(HAVE_SYSTEMD, [test -n "$with_systemdsystemunitdir" -a "x$with_systemdsystemunitdir" != xno ])
AC_MSG_RESULT([done])

AC_CONFIG_FILES([Makefile
		 src/Makefile
		 conf/Makefile
		 recipe/Makefile
		 src/discover-host.rb
		 conf/foreman-plugin.firewall
		 src/discovery-version-fact.rb
		 ovirt-node-plugin-foreman.spec])

AC_OUTPUT
