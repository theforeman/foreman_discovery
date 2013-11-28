# oVirt Node discovery image

This page describes how to download, build and configure discovery image.

# Building the Discovery PXE Image

The process is described on a [separate wiki
page](extra/ovirt-node-plugin-foreman/README.md).

# Downloading existing Discovery PXE Image

*Alpha version* of Foreman Discovery image (0.1.0) are [available for
download] (http://lzap.fedorapeople.org/zzz/). These images were build in the
production mode - root account is locked.

We provide both ISO file which can be used for injection of modified Discovery
plugin or even other oVirt Node plugins, and extracted kernel and initrd.

To setup kernel and initial RAM disk on a TFTP server do something like:

    cd /var/lib/tftpboot/boot
    wget http://lzap.fedorapeople.org/zzz/discovery-initrd.img
    wget http://lzap.fedorapeople.org/zzz/discovery-vmlinuz

Check permissions and ownership after that.

# Configuration

## PXE config

To configure discovery booting modify provisioning template named "PXE Default
File":

    DEFAULT menu
    PROMPT 0
    MENU TITLE PXE Menu
    TIMEOUT 200
    TOTALTIMEOUT 6000
    ONTIMEOUT discovery

    LABEL discovery
    MENU LABEL Foreman Discovery
    KERNEL boot/discovery-vmlinuz
    APPEND rootflags=loop initrd=boot/discovery-initrd.img root=live:/foreman.iso rootfstype=auto ro rd.live.image rd.live.check rd.lvm=0 rootflags=ro crashkernel=128M elevator=deadline max_loop=256 rd.luks=0 rd.md=0 rd.dm=0 foreman.ip=192.168.122.1 nomodeset selinux=0 stateless

Note the long line and selinux is disabled for oVirt Node image. Also do not
forget to press "Build PXE Default" button afterwards.

Be sure to alter the foreman.ip appropriately. You can also use foreman.server to
specify a DNS record (`foreman.server=myforemanhost`) but in this case the port will
be assumed to be http (80). If all else fails (say, USB boot where we can't provide
options) it will look for a DNS record of `foreman`.

# Known Issues with the image

## Unable to login on the running image

Root account and ssh are disabled on production images, to get a shell you
need to build your own image (see above) and provide debug option there.

# More configuration

Some configuration needs to be done in Foreman - go back to the [discovery
readme](README.md) to find out more.
