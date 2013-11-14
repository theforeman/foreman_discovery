# Tine Core Linux discovery image

This page describes how to download, build and configure discovery image.

# Downloading existing Discovery PXE Image

We provide pre-built images that can be directly used with Foreman:

* [production images](http://deb.theforeman.org/discovery_image_prod/)
* [development images](http://deb.theforeman.org/discovery_image_debug/)

# Building the Discovery PXE Image

There is a rake task for the discovery image. Run this rake task to create the
image:

    foreman-rake discovery:build_image

You image will be in ./discovery\_image. Run the rake task as root, or with
passwordless sudo, as the password prompts may get lost in the ruby->bash
forking process.

# Configuration

## Image configuration

The PXE image has two configuration options during build:

* By default it will have an automatic login to the 'tc' user and start ssh so
you can ssh to `tc@<ip>` with password test1234. By specifying `mode=prod` on
the rake task, you can disable both of these - the image will have no accounts
that can be logged in

* If you need to add additional files to the image, put them in
`./additional_build_files/` - these will be copied to
`/additional_build_files/` in the image

Also, it will attempt todownload `/discovery_init.sh` from your Foreman server
and run it. This is entirely optional - if the server cannot be reached or the
file cannot be found, the image has a fallback script built in.

You can find an example script [here](extra/discovery_init.sh.example) - place your
modified version in the `public/` directory on your Foreman server.

## PXE config

Configure the PXE default to boot the Discovery Image built above, eg:

    DEFAULT menu
    PROMPT 0
    MENU TITLE PXE Menu
    TIMEOUT 200
    TOTALTIMEOUT 6000
    ONTIMEOUT discovery

    LABEL discovery
    MENU LABEL Boot Discovery
    TEXT HELP
    Boot the Foreman Discovery Image
    Use TAB to edit options for specific needs.
    ENDTEXT
    KERNEL /boot/TinyCore-vmlinuz
    APPEND initrd=/boot/TinyCore-initrd.gz foreman.ip=192.168.122.1

Be sure to alter the foreman.ip appropriately. You can also use foreman.server
to specify a DNS record (`foreman.server=myforemanhost`) but in this case the
port will be assumed to be http (80). If all else fails (say, USB boot where
we can't provide options) it will look for a DNS record of `foreman`

# Known Issues with the image

On some multi-core systems the TinyCore kernel may segfault on boot with an
error message similar to :

    "Fixing recursive fault but reboot is needed!"

If this happens, it can be fixed by changing the KERNEL line in the PXE config
above to read :

    KERNEL /boot/TinyCore-vmlinuz maxcpus=1

More information on the maxcpus kernel parameter can be found at
<https://www.kernel.org/doc/Documentation/kernel-parameters.txt>

A currently unavoidable side effect of this setting is that the initial facts
gathered during discovery will only show a single processor, since that is all
that is visible to the kernel.

# More configuration

Some configuration needs to be done in Foreman - go back to the [discovery
readme](README.md) to find out more.
