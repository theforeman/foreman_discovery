#!/bin/bash
# vim: sw=2:ts=2:et
set -x

base_image_url=${1}
buildnumber=${2}
proxy_repo=${3}
repoowner=${4}
branch=${5}

echo Building $repoowner/$branch from $base_image_url and $proxy_repo

cat > ./fedora.repo <<'EOF'
[fedora-edit-node]
name=Fedora $releasever - $basearch
#baseurl=http://download.fedoraproject.org/pub/fedora/linux/releases/$releasever/Everything/$basearch/os/
baseurl=http://mirror.rackspace.com/fedora/releases/$releasever/Everything/$basearch/os/
#mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=fedora-$releasever&arch=$basearch
failovermethod=priority
retries=200
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$basearch

[updates-edit-node]
name=Fedora $releasever - $basearch - Updates
#baseurl=http://download.fedoraproject.org/pub/fedora/linux/updates/$releasever/$basearch/
baseurl=http://mirror.rackspace.com/fedora/updates/$releasever/$basearch/
#mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=updates-released-f$releasever&arch=$basearch
failovermethod=priority
retries=200
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$basearch
EOF

cat > ./foreman.repo <<EOF2
[foreman]
name=Foreman nightly
baseurl=$proxy_repo
enabled=1
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-foreman
EOF2

cat fedora.repo foreman.repo > edit-node.repo

export OVIRT_NODE_BASE=$PWD
export OVIRT_CACHE_DIR=~/ovirt-cache
export OVIRT_LOCAL_REPO=file://${OVIRT_CACHE_DIR}/ovirt
mkdir -p $OVIRT_CACHE_DIR

# give the VM some time to finish booting and network configuration
sleep 40

yum -y install livecd-tools appliance-tools-minimizer fedora-packager \
    python-devel rpm-build createrepo selinux-policy-doc checkpolicy \
    selinux-policy-devel autoconf automake python-mock python-lockfile git wget
git clone http://gerrit.ovirt.org/p/ovirt-node.git
git clone http://gerrit.ovirt.org/p/ovirt-node-iso.git
git clone https://github.com/$repoowner/foreman_discovery.git -b $branch

BASE_IMAGE=$(basename $base_image_url)
VERSION=$(grep AC_INIT foreman_discovery/extra/ovirt-node-plugin-foreman/configure.ac | grep -oE '[0-9].[0-9].[0-9]')-$buildnumber

wget -q -nc -c "$base_image_url"

function build() {
        RPMSDIR=$(rpm --eval '%{_rpmdir}')
        rm -f $RPMSDIR/noarch/*rpm
        pushd foreman_discovery/extra/ovirt-node-plugin-foreman
        git pull
        make distclean
        if [[ "$1" == "debug" ]]; then
                ./autogen.sh --enable-debug && make rpms
        else
                ./autogen.sh && make rpms
        fi
        popd
        cat edit-node.repo
        ovirt-node/tools/edit-node --repo edit-node.repo --nogpgcheck \
                --install $RPMSDIR/noarch/ovirt-node-plugin-foreman-0*.rpm \
                $BASE_IMAGE
        echo edit-node returned: $?
        mv -f ovirt-node-iso-*.foreman.*.iso foreman.iso
        rm -rf tftpboot
        livecd-iso-to-pxeboot foreman.iso
        mv -f tftpboot/vmlinuz0 discovery-$1-$VERSION-vmlinuz
        mv -f tftpboot/initrd0.img discovery-$1-$VERSION-initrd.img
        mv -f foreman.iso foreman-discovery-$1-$VERSION.iso
}

build prod
build debug


