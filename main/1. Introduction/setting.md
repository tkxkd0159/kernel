---
sort: 1
---

# Basic Setting

`{{ page.path }}`
## Prerequisites
```
sudo apt-get install git bc bison flex libssl-dev
```
## Compile the Kernel
Download latest stable kernel source code from `kernel.org`
```bash
tar xf linux-5.7.2.tar.xz && cd linux-5.7.2
cp /boot/config-$(uname -r) .config
make menuconfig
make -j12
sudo make install
sudo update-grub
sudo reboot
```

## VM setting
```bash
qemu-img create -f qcow2 ubuntu_test.img 10G
qemu-img info ubuntu_test.img

# setting image and install guest OS(shutdown after finish install)
sudo qemu-system-x86_64 \
-name "ljsvm" \
-m 4096 \
-drive file=/home/ljsku/ubuntu_test.img,if=virtio \
-cdrom /home/ljsku/ubuntu-20.04.iso \
-rtc base=localtime \
-vga virtio \
-device virtio-keyboard-pci \
-boot d


# Run qemu instance

sudo qemu-system-x86_64 \
--enable-kvm \
-name "ljsvm" \
-m 4096 \
-drive file=/home/ljsku/ubuntu_test.img,if=virtio \
-cdrom /home/ljsku/ubuntu-20.04.iso \
-rtc base=localtime \
-vga virtio \
-device virtio-keyboard-pci


# ensure that the qemu instance is running and terminate:
pgrep -lfa qemu
pkill qemu-system-x86_64 or kill <pid>

#
ps -ef | grep qemu-system-x86_64
```