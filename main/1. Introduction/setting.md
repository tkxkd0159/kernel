---
sort: 1
---

# Basic Setting

`{{ page.path }}`

- [Basic Setting](#basic-setting)
  - [Prerequisites](#prerequisites)
    - [Select kernel](#select-kernel)
  - [Install KVM](#install-kvm)
  - [Compile the Kernel](#compile-the-kernel)
    - [Change kernel name](#change-kernel-name)
    - [Change uname](#change-uname)
  - [VM setting](#vm-setting)
  - [Binary Utility](#binary-utility)

## Prerequisites

```bash
sudo apt install bison flex fakeroot build-essential makedumpfile kernel-wedge libncurses5 libncurses5-dev libelf-dev binutils-dev libudev-dev libpci-dev libiberty-dev libssl-dev autoconf
```
## Install KVM

```bash
# Pre-installation check
egrep -c '(vmx|svm)' /proc/cpuinfo # it must be 1 or higher
kvm-ok

# install KVM
sudo apt-get install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils
sudo adduser `id -un` libvirt
sudo adduser `id -un` kvm

# Verify installation
virsh list --all
sudo ls -la /var/run/libvirt/libvirt-sock
ls -l /dev/kvm
```

## Compile the Kernel

### Get preprocessor output (.i files)
Makefile의 **KBUILD_CFLAGS**에 `-save-temp=obj` 추가
### Change kernel name

```
$ make menuconfig
General Setup -> Local version
```

### Change uname

include > linux > uts.h

```
UTS_SYSNAME <my-custom-name>
```

Download latest stable kernel source code from [kernel.org](https://www.kernel.org/)  
or https://wiki.ubuntu.com/Kernel/BuildYourOwnKernel  
`git clone git://kernel.ubuntu.com/ubuntu/ubuntu-focal.git`

```bash
wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.4.92.tar.xz
tar xf linux-5.4.92.tar.xz && cd linux-5.4.92
cp /boot/config-$(uname -r) .config
make menuconfig
sudo make [O=<target_dir>] -j 12 # O는 build output 위치, 그 위치에 .config가 존재해야 빌드 가능
sudo make [O=<target_dir>] modules_install
sudo make [O=<target_dir>] install
sudo update-grub
reboot 
```
### Select kernel

```bash
# /boot/grub/grub.cfg -> menuentry 검색
# 제일 처음 menuentry : GRUB_DEFAULT=0
# n번째 submenu 안의 m번째 menuentry : GRUB_DEFAULT="n>m"

sudo vim /etc/default/grub #GRUB_DEFAULT 수정

# 부팅 시 커널 선택 창을 띄우고 싶을 때
GRUB_TIMEOUT_STYLE=menu
GRUM_TIMEOUT=-1

sudo update-grub
```

## Build and Install Result
```bash
# lib/modules
 <kernel-version>-generic

 # /boot
 System.map-<kernel-version>
 initrd.img-<kerner-version>
 vmlinuz-<kerner-version>
```

## Check kernel list
package manager로 받은 것들
```bash
sudo dpkg --list | egrep -i --color 'linux-image|linux-headers'

# delete unused kernel
sudo apt --purge autoremove

```

## VM setting

```bash
qemu-img create -f qcow2 ubuntu_test.img 100G
qemu-img info ubuntu_test.img

# setting image and install guest OS(shutdown after finish install)
./myqemu.sh -c


# Run qemu instance
./myqemu.sh

# ensure that the qemu instance is running and terminate:
pgrep -lfa qemu
pkill qemu-system-x86_64 or kill <pid>

#
ps -ef | grep qemu-system-x86_64
```
## Binary Utility

| name      | description                            |
| --------- | -------------------------------------- |
| objdump   | library나 ELF file을 어셈블리어로 출력 |
| as        | assembler                              |
| ld        | linker                                 |
| addr2line | 주소를 파일과 라인으로 출력            |
| nm        | object file의 symbol을 출력            |
| readelf   | elf file의 내용을 출력                 |

## How to create virtual block device (loop device/filesystem) in Linux
```bash
# Create a file
dd if=/dev/zero of=loopbackfile.img bs=100M count=10

# Create the loop device
losetup -fP --show loopbackfile.img

# Check loop device list
losetup -a

# Create the filesystem
mkfs.ext4 /root/loopbackfile.img

# Mount the loopback filesystem
mkdir /loopfs
mount -o loop /dev/loop0 /loopfs

# Verify the size of the new mount point and type of file system
df -h /loopfs/
mount | grep loopfs

# Remove loop device
umount /loopfs
rmdir /loopfs
losetup -d /dev/loop0
rm /root/loopbackfile.img
```