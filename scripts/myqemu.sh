#!/bin/bash
# remove the colons from the options that don't require arguments

usage() { echo "Usage: $0 [-c : create,[-o <OS-img>]] [-i <qemu-img>] [-w <working directory>] [-m <int> : memory] " 1>&2; exit 1; }

#OPT_BOOL=${1:-False}

OPTIND=1
CREATE=0
IMG="ubuntu100.img"
WD="kernel_test"
OS="ubuntu-20.04.1-desktop-amd64.iso"
SMP=4
RAM=4096

while getopts "h?ci:w:o:m:" opt; do
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
			;;
		m)
			RAM=${OPTARG:-$RAM}	
	esac
done

shift $((OPTIND-1))

echo "isCreate=$CREATE, qemu-img : ${IMG}, RAM :${RAM}, nproc:${SMP}"

if [ $CREATE = true ]; then
	sudo qemu-system-x86_64 \
		--enable-kvm \
		-name "ljsvm" \
		-cpu host \
		-smp ${SMP} \
		-m ${RAM} \
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
		-cpu host \
		-smp ${SMP} \
		-m ${RAM} \
		-drive file=/home/$(users)/${WD}/${IMG},if=virtio \
		-rtc base=localtime \
		-vga virtio \
		-device virtio-keyboard-pci
fi
