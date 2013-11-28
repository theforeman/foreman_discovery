# Minimize script optimized for Foreman Discovery plugin (Fedora 19)
#
# Use this to find interesting packages in the image:
#
#  rpm -qa --queryformat '%{SIZE} %{NAME}\n' | sort -n -r | head -n100
# 
# Use this tool (part of this plugin) to check for missing libs:
#
#  find-missing-libs
#

# ovirt-node and deps
droprpm ovirt-node
droprpm collectd
droprpm collectd-*

# virtualization
droprpm qemu
droprpm qemu-*
droprpm ipxe-roms-qemu
droprpm xen-licenses
droprpm vhostmd
droprpm libvirt
droprpm libvirt-*

# python
droprpm python
droprpm python-*
droprpm *-python
droprpm pyliblzma
droprpm pyxattr
droprpm pygpgme
droprpm pygobject*

# selinux (need to provide selinux=0 kernel argument)
droprpm selinux-policy-targeted
droprpm policycoreutils

# x window
droprpm cairo
droprpm cairo-gobject
droprpm colord-libs
droprpm gdk-pixbuf2
droprpm gsettings-desktop-schemas
droprpm gtk3
droprpm hicolor-icon-theme
droprpm libsndfile
droprpm libvorbis
droprpm libX*
droprpm libxcb
droprpm mesa-*
droprpm pango
droprpm pulseaudio-libs
droprpm SDL
droprpm vte3

# various
droprpm acpid
droprpm aic94xx-firmware
droprpm alsa-lib
droprpm anyterm
droprpm avahi
droprpm bc
droprpm bfa-firmware
droprpm bridge-utils
droprpm btrfs-progs
droprpm ceph-libs
droprpm cracklib-dicts
droprpm device-mapper-multipath
droprpm dmraid
droprpm dosfstools
droprpm dracut-fips
droprpm dracut-network
droprpm e2fsprogs
droprpm efibootmgr
droprpm fcoe-utils
droprpm gdb
droprpm glusterfs
droprpm glusterfs-*
droprpm hwdata
droprpm irqbalance
droprpm iscsi-initiator-utils
droprpm jfsutils
droprpm kbd-misc
droprpm kexec-tools
droprpm kpartx
droprpm less
droprpm libguestfs
droprpm libguestfs-*
droprpm libicu
droprpm libmlx4
droprpm mcelog
droprpm net-snmp-libs
droprpm ntfs-3g
droprpm ntfsprogs
droprpm numactl
droprpm openssh-clients
droprpm parted
droprpm patch
droprpm pciutils
droprpm plymouth
droprpm plymouth-*
droprpm poppler-data
droprpm psmisc
droprpm PyPAM
droprpm reiserfs-utils
droprpm rsync
droprpm rsyslog
droprpm setools-console
droprpm sos
droprpm spice-server
droprpm squashfs-tools
droprpm strace
droprpm sysfsutils
droprpm sysstat
droprpm systemtap-runtime
droprpm tcpdump
droprpm tuned
droprpm tzdata
droprpm urw-fonts
droprpm usbutils
droprpm vconfig
droprpm xen-libs
droprpm xfsprogs
droprpm zfs-fuse

# various files/directories
drop /usr/share/gems/cache
drop /usr/share/qemu
drop /usr/share/mime
drop /usr/share/groff
drop /usr/share/locale

# The following packages are REQUIRED
#
# ruby
# facter
# sudo
# ipmitool

# The following packages are required to boot
#
# ncurses-libs
# NetworkManager-glib
# grubby
# libselinux
# lua
# sqlite
# openldap
# mozjs17

# The following packages SHOULD not be dropped
# (used in development mode)
#
# file
# vim-minimal
# openssh-server
# lsof

# EOF
