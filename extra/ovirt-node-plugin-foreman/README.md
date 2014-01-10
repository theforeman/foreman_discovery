Foreman Discovery oVirt Node Plugin
===================================

There are couple of options how to get a oVirt Node Discovery image:

* Downloading existing one is the easiest method, but the image does not
  provide site-specific options.

* Downloading existing oVirt Node base image and injecting plugin into it.
  This is the recommended process of creating your own image. It is fast and
  still provides great flexibility of customization of the resulting image.

* Building own oVirt Node base image and injecting the plugin into it. This
  option must be used if you want to play with latest and greatest base image.

All three processes are described on this page.

Downloading image
-----------------

We provide download links on the [Foreman Discovery plugin
page](https://github.com/theforeman/foreman_discovery).

Injecting into existing base image
----------------------------------

Warning: This process will set SELinux to permissive mode during the build of
new iso image. Since this can compromise security, it is highly recommended to
use dedicated VM guest for building images.

Although it is not possible to use stable version (3.0) for a base image,
there are couple of [nightly
builds](http://resources.ovirt.org/releases/node-base/nightly/iso/) that can
be used. It seems any image from version 3.0.3 can be used.

Discovery image 0.3.0 is built from 0.3.0-1.1.fc19 base iso image:

    wget http://resources.ovirt.org/releases/node-base/nightly/iso/ovirt-node-iso-3.0.3-1.1.fc19.iso

We plan to release Fedora and RHEL based discovery images built from oVirt
Node stable version 3.1.

Building the base image from git
--------------------------------

Building the discovery image involves two main steps:

 * Building base oVirt Node ISO from git.
 * Building the discovery plugin and inserting it into the existing ISO.

Follow instructions on [oVirt
wiki](http://www.ovirt.org/Node_Building#From_Git) to build the base oVirt
Node ISO. Before proceeding, check the instruction on the oVirt page as they
may change in future. What we have here might be different when using master.

We are using clean VM guest of Fedora 19 and directly from root account. If
you want to build using different user, check out the building instructions
above and setup sudo for some commands. Make sure you have at least 4 GB of
free space on the partition you are building on.

First of all, fetch ovirt-node utilities and image builder:

    git clone http://gerrit.ovirt.org/p/ovirt-node.git
    git clone http://gerrit.ovirt.org/p/ovirt-node-iso.git

Build ovirt-node packages:

    export OVIRT_NODE_BASE=$PWD
    export OVIRT_CACHE_DIR=~/ovirt-cache
    export OVIRT_LOCAL_REPO=file://${OVIRT_CACHE_DIR}/ovirt
    mkdir -p $OVIRT_CACHE_DIR
    yum install livecd-tools appliance-tools-minimizer fedora-packager \
        python-devel rpm-build createrepo selinux-policy-doc checkpolicy \
        selinux-policy-devel autoconf automake python-mock python-lockfile
    cd $OVIRT_NODE_BASE
    cd ovirt-node
    export EXTRA_RELEASE=.foreman
    ./autogen.sh --with-image-minimizer
    make publish

Build the base image and move it to the base directory:

    cd $OVIRT_NODE_BASE
    cd ovirt-node-iso
    ./autogen.sh --with-recipe=$OVIRT_NODE_BASE/ovirt-node/recipe
    make iso
    mv ovirt-node-iso-*.iso $OVIRT_NODE_BASE/

Now we are ready to inject our plugin.

*Troubleshooting*

If you encounter any problem during build, check internet connection first
and try again. Occasionally, package cannot be downloaded from a nearest
mirror so the process can fail. If the problem persists, you can try with
exact githash or tag we were building from:

    cd ovirt-node
    make distclean
    git checkout 2e54ec17b55e1ee80
    cd ../ovirt-node-iso
    make distclean
    git checkout 5ac5557fc5521d644
    cd ..

Also note that *building EL6 image (even on EL6 guest builder) is not
supported* right now.

Building and injecting the discovery plugin
-------------------------------------------

This second phase must be done on the same machine where base image was built.
Please do not clean ovirt-node and cache directory as it is being used here.

Building the plugin is much faster than building the base ISO and you can
repeat this step more times. The base (source) ISO file will not get modified
so you do not need to create any backup.

Whole process can be described:

 * Discovery plugin is build as an RPM and copied to `OVIRT_CACHE` directory.
 * Base ISO is unpacked, mounted.
 * Discovery RPM plugin is installed into the image making necessary changes.
 * Many packages are uninstalled from the image shrinking size down to 170MB.
 * Image is cleaned and wrapped back as ISO with ".foreman." version tag.
 * Kernel image and init ram disk is extracted from the ISO.

First of all we build plugin RPMs. Before that, we are going to clear the
RPMSDIR directory just to make sure it's clean and publish it to the cache repository.

    cd $OVIRT_NODE_BASE
    RPMSDIR=$(rpm --eval '%{_rpmdir}')
    rm -f $RPMSDIR/noarch/*rpm
    git clone https://github.com/theforeman/foreman_discovery.git
    cd foreman_discovery/extra/ovirt-node-plugin-foreman
    ./autogen.sh
    make rpms

Now, let's modify the base ISO image and install the plugin there.

    cd $OVIRT_NODE_BASE

Create a new repo file in this directory with the following contents.

    cat > ./foreman.repo <<'EOF'
    [fedora-edit-node]
    name=Fedora $releasever - $basearch
    failovermethod=priority
    baseurl=http://download.fedoraproject.org/pub/fedora/linux/releases/$releasever/Everything/$basearch/os/
    #mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=fedora-$releasever&arch=$basearch
    enabled=1
    gpgcheck=1
    gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$basearch

    [updates-edit-node]
    name=Fedora $releasever - $basearch - Updates
    failovermethod=priority
    baseurl=http://download.fedoraproject.org/pub/fedora/linux/updates/$releasever/$basearch/
    #mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=updates-released-f$releasever&arch=$basearch
    enabled=1
    gpgcheck=1
    gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$basearch

    [foreman]
    name=Foreman nightly
    baseurl=http://yum.theforeman.org/nightly/f19/$basearch
    enabled=1
    gpgcheck=0
    gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-foreman
    EOF

These three repositories will be used to install extra packages from Fedora 19
and also Foreman Proxy from nightly repository. You can switch to Foreman 1.3+
stable repository if you want. Injection is easy and quite fast:

    ovirt-node/tools/edit-node \
        --repo foreman.repo \
        --nogpgcheck \
        --install $RPMSDIR/noarch/ovirt-node-plugin-foreman-0*.rpm \
        --verbose \
        --debug \
        ovirt-node-iso-*.iso
    mv -f ovirt-node-iso-*.foreman.*.iso foreman.iso
    test -d tftpboot && rm -rf tftpboot
    livecd-iso-to-pxeboot foreman.iso

Note we are renaming the target ISO to foreman.iso prior extracting kernel and
initrd, otherwise you'd need to change kernel boot options.

Finally, it's the time to copy those files to TFTP server:

    scp tftpboot/initrd0.img root@tftp_server:/var/lib/tftpboot/boot/discovery-initrd.img
    scp tftpboot/vmlinuz0 root@tftp_server:/var/lib/tftpboot/boot/discovery-vmlinuz

Setup Foreman templates
-----------------------

Read instructions about how to setup Foreman and PXE on the following pages:

* [Foreman Discovery oVirt Node instructions](../../README.ovirt_image.md)
* [Foreman Discovery instructions](../../README.md)

Development
-----------

The image is locked down, the root account is locked and there is no ssh
daemon running on the image. But all of this can be enabled and few more
command line utilities can be installed, if the plugin is configured with this
option:

    make distclean
    ./autogen.sh --enable-debug

The root password is set to "development" and ssh daemon is listening on the
standard port. Also logging of discover-host and foreman-proxy services is
increased to DEBUG level. See /tmp directory.

