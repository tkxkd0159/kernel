#!/bin/bash
# remove the colons from the options that don't require arguments

usage() { echo "Usage: $0 [-c : create] [-i <qemu-img>] [-w <working directory>] " 1>&2; exit 1; }

OPTIND=1
CREATE=0
IMG="ubuntu_test.img"
WD="kernel_test"
OS="ubuntu-20.04.1-desktop-amd64.iso"

while getopts "h?ci:w:o:" opt; do
	case "$opt" in
		h|\?)
			usage
			;;
		c) 
			CREATE=true
			;;
		i)
			IMG=${OPTARG}
			;;
		w)
			WD=${OPTARG}
			;;
		o)
			OS=${OPTARG}	
	esac
done

shift $((OPTIND-1))

if [ $CREATE = true ]; then
	sudo qemu-system-x86_64 \
		-name "ljsvm" \
		-m 4096 \
		-drive file=/home/$(users)/${WD}/${IMG},if=virtio \
		-cdrom /home/$(users)/${WD}/${OS} \
		-rtc base=localtime \
		-vga virtio \
		-device virtio-keyboard-pci \
		-boot d
else
	sudo qemu-system-x86_64 \
		--enable-kvm \
		-name "ljsvm" \
		-m 4096 \
		-drive file=/home/$(users)/${WD}/${IMG},if=virtio \
#		-cdrom /home/$(users)/${WD}/${OS} \
		-rtc base=localtime \
		-vga virtio \
		-device virtio-keyboard-pci
fi

echo "isCreate=$CREATE leftovers: $@ "
