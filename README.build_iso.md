# Building an ISO

This document assumes you have already run the rake task for building the discovery
boot image (see main README). As such, you should already have:

    ./discovery_image/vmlinuz
    ./discovery_image/initrd.gz
    /tmp/tcl.iso

Now you wish to build an ISO of these files.

# Dependencies

You'll need `genisoimage`

# Procedure

    mkdir newiso
    sudo mount /tmp/tcl.iso /mnt -oloop
    cp -r /mnt/boot newiso
    sudo umount /mnt
    sudo mv discovery_image/vmlinuz newiso/boot/vmlinuz
    sudo mv discovery_image/initrd.gz newiso/boot/core.gz
    sudo genisoimage -quiet -l -J -R \
        -no-emul-boot -boot-load-size 4 -boot-info-table \
        -b boot/isolinux/isolinux.bin \
        -c boot/isolinux/boot.cat \
        -o "discovery.iso" newiso/

You should now have discovery.iso and can boot it. As there is no way to pass any boot-time
information to the image, you will need to ensure there is a DNS record for "foreman" that
the image can resolve.
