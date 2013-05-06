#!/bin/bash

## Remaster TCL for the Discovery Image
# (from http://wiki.tinycorelinux.net/wiki:remastering)
#
# This script will build the boot image. You will need squashfs-tools and
# advancecomp. Run it as root, or with passwordless sudo, or the password prompts
# may get lost when the rake task is run.

# Image type
MODE=$1

# Setup
GEMS="facter json_pure rack rack-protection tilt sinatra"
TGZS="libssl-0.9.8 ruby firmware firmware-bnx2 firmware-broadcom scsi-3.0.21-tinycore dmidecode lldpad"
if [[ $MODE == 'debug' ]] ; then
  TGZS="$TGZS gcc_libs openssl-1.0.0 openssh"
fi

LAUNCH_DIR=`pwd`
TOPDIR=`mktemp -d`
cd $TOPDIR

# Download/Unpack TCL ISO
if [ -f /tmp/tcl.iso ]; then
  echo "Using cached TCL iso"
  cp /tmp/tcl.iso ./tcl.iso
else
  wget http://distro.ibiblio.org/tinycorelinux/4.x/x86/release/Core-current.iso -O tcl.iso
  cp tcl.iso /tmp/tcl.iso
fi
mkdir loop && mount -oloop tcl.iso loop/
cp loop/boot/core.gz loop/boot/vmlinuz .
umount loop && rmdir loop

# Modify basic image:
mkdir extract && cd extract
zcat $TOPDIR/core.gz | sudo cpio -i -H newc -d

# add link for dmidecode so facter can detect it.
ln -s /usr/local/sbin/dmidecode usr/sbin/dmidecode

# Include static additional files
mkdir ./additional_build_files
wget -O ./additional_build_files/ipmi.rb https://github.com/zoide/puppet-ipmi/raw/master/lib/facter/ipmi.rb
wget -O ./additional_build_files/lldp.rb https://github.com/mfournier/puppet-lldp/raw/master/lib/facter/lldp.rb
if [ -d $LAUNCH_DIR/additional_build_files ]; then
  echo "including files from $LAUNCH_DIR/additional_build_files"
  cp -r $LAUNCH_DIR/additional_build_files .
fi

# Account/SSH setup
cd $TOPDIR/extract
if [[ $MODE == "prod" ]] ; then
  # Prod mode, lock out the accounts
  echo "Prod mode; disabling shell"
  cat > etc/passwd <<EOF
root:x:0:0:root:/root:/bin/sh
lp:x:7:7:lp:/var/spool/lpd:/bin/sh
nobody:x:65534:65534:nobody:/nonexistent:/bin/false
tc:x:1001:50:Linux User,,,:/home/tc:/bin/sh
EOF
  cat > etc/shadow <<EOF
root:*:13525:0:99999:7:::
lp:*:13510:0:99999:7:::
nobody:*:13509:0:99999:7:::
tc:*:15492:0:99999:7:::
EOF
  sed -i 's/-nl \/sbin\/autologin.*/38400 tty1/' etc/inittab
else
  echo "Debug mode; enabling SSH"
  echo "" >> opt/bootlocal.sh
  echo "ssh-keygen -t rsa -f /usr/local/etc/ssh/ssh_host_rsa_key -N ''" >> opt/bootlocal.sh
  echo "ssh-keygen -t dsa -f /usr/local/etc/ssh/ssh_host_dsa_key -N ''" >> opt/bootlocal.sh
  echo "ssh-keygen -t ecdsa -f /usr/local/etc/ssh/ssh_host_ecdsa_key -N ''" >> opt/bootlocal.sh
  echo "cp /usr/local/etc/ssh/sshd_config.example /usr/local/etc/ssh/sshd_config" >> opt/bootlocal.sh
  cat > etc/shadow <<EOF
root:*:13525:0:99999:7:::
lp:*:13510:0:99999:7:::
nobody:*:13509:0:99999:7:::
tc:\$1\$TdSq3t4T\$yCDutSXcI9meEywIoopbu/:15492:0:99999:7:::
EOF
  echo "/usr/local/sbin/sshd" >> opt/bootlocal.sh
fi

# Build the init script
echo "" >> opt/bootlocal.sh
echo "sleep 20" >> opt/bootlocal.sh # network can be slow to come up, and we're not in a rush
echo "/opt/foreman_startup.rb" >> opt/bootlocal.sh
echo "/opt/discovery_init.sh" >> opt/bootlocal.sh

# Get the downloader
cp `dirname $0`/foreman_startup.rb opt/foreman_startup.rb
chmod 755 opt/foreman_startup.rb

# Get the gems
mkdir opt/gems && cd opt/gems
for n in $GEMS ; do gem fetch $n ; done

# Build the fallback script
echo "#!/bin/sh" >> ../discovery_init.sh
for n in $GEMS ; do echo "gem install -l --no-ri --no-rdoc /opt/gems/`ls *$n-[0-9]*.gem`" >> ../discovery_init.sh ; done
echo "" >> ../discovery_init.sh
echo 'FACTER_LIB=`gem which facter`' >> ../discovery_init.sh
echo 'FACTER_PATH=`dirname $FACTER_LIB`' >> ../discovery_init.sh
echo 'cp /additional_build_files/ipmi.rb $FACTER_PATH/facter/ipmi.rb' >> ../discovery_init.sh
echo 'cp /additional_build_files/lldp.rb $FACTER_PATH/facter/lldp.rb' >> ../discovery_init.sh
echo 'cp /additional_build_files/netinfo.rb $FACTER_PATH/facter/netinfo.rb' >> ../discovery_init.sh
echo "/usr/share/foreman-proxy/bin/smart-proxy" >> ../discovery_init.sh
echo "/usr/share/foreman-proxy/bin/discover_host" >> ../discovery_init.sh
chmod 755 ../discovery_init.sh

# Repack
cd $TOPDIR/extract
find | cpio -o -H newc | gzip -2 > $TOPDIR/tinycore.gz
cd $TOPDIR && advdef -z4 tinycore.gz
rm -rf $TOPDIR/extract
IMAGES="tinycore.gz "

# Convert TGZs to GZs
for url in $TGZS ; do
  wget http://repo.tinycorelinux.net/4.x/x86/tcz/$url.tcz
  unsquashfs $url.tcz && cd squashfs-root
  find | cpio -o -H newc | gzip -2 > ../$url.gz
  cd .. && advdef -z4 $url.gz
  rm -rf squashfs-root
  IMAGES="$IMAGES $url.gz "
done

# Build Rubygems:
wget http://production.cf.rubygems.org/rubygems/rubygems-1.8.24.tgz
mkdir tmp-install-rubygems && cd tmp-install-rubygems
mkdir rubygems
tar xvzf ../rubygems-1.8.24.tgz && cd rubygems-1.8.24
ruby setup.rb --destdir=../rubygems --prefix=/usr/local
cd ../rubygems
sed -i 's?#!.*?#!/usr/local/bin/ruby?' ./usr/local/bin/gem
mkdir ./usr/local/lib/ruby/1.8 -p
mv ./usr/local/lib/* ./usr/local/lib/ruby/1.8
chown -R 0:0 .
find | cpio -o -H newc | gzip -2 > $TOPDIR/rubygems.gz
cd $TOPDIR && advdef -z4 rubygems.gz
rm -rf tmp-install-rubygems rubygems-1.8.24.tgz
IMAGES="$IMAGES rubygems.gz "

# Proxy.gz
mkdir -p ./proxy/usr/share
mkdir -p ./proxy/var/run/foreman-proxy
mkdir -p ./proxy/var/log/foreman-proxy
git clone https://github.com/theforeman/smart-proxy.git ./proxy/usr/share/foreman-proxy
cp `dirname $0`/discover_host ./proxy/usr/share/foreman-proxy/bin/discover_host
chmod 755 ./proxy/usr/share/foreman-proxy/bin/discover_host
cp ./proxy/usr/share/foreman-proxy/config/settings.yml{.example,}
sed -i 's/.*:bmc:.*/:bmc: true/' ./proxy/usr/share/foreman-proxy/config/settings.yml
sed -i 's/.*:bmc_default_provider:.*/:bmc_default_provider: shell/' ./proxy/usr/share/foreman-proxy/config/settings.yml
#Shell interface calls shutdown which doesn't exist in TCL
mkdir -p ./proxy/sbin
echo -e "#\x21/bin/sh\nexec /sbin/reboot" > ./proxy/sbin/shutdown
chmod 755 ./proxy/sbin/shutdown
cd proxy
find | cpio -o -H newc | gzip -2 > ../proxy.gz
cd $TOPDIR && advdef -z4 proxy.gz
rm -rf proxy
IMAGES="$IMAGES proxy.gz"

# Use Gz chaining:
cat $IMAGES > initrd.gz
chmod 755 $TOPDIR
echo "#TMPDIR# $TOPDIR"
