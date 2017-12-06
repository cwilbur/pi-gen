#!/bin/bash -e

install -m 644 files/cmdline.txt ${ROOTFS_DIR}/boot/
install -m 644 files/config.txt ${ROOTFS_DIR}/boot/

# when PI_ZERO_OTG is "1":
# make an image that uses OTG Gadget USB networking by default:
# - add 'modules-load=dwc2,g_ether' to boot/cmdline.txt after 'rootwait'
# - add 'dtoverlay=dwc2' to boot/config.txt
# - make sure the file boot/ssh exists

if [ "$PI_ZERO_OTG" = "1" ]; then
	sed -i 's/rootwait/rootwait modules-load=dwc2,g_ether/' files/boot/cmdline.txt
	echo 'dtoverlay=dwc2' >> files/boot/config.txt
	touch files/boot/ssh
fi

