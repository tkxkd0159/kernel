# virt-viewer
# virsh list --all
# virsh shutdown <VM>
# virsh start <VM>
# virsh destroy <VM>
# virsh reboot <VM>

# virsh undefine <VM>
# virsh define filename.xml

# virsh attach-disk
# virsh attach-interface
# virsh edit <VM>


UPPER_DIR=$( pwd -P )
echo${UPPER_DIR}

virt-install \
--name focal2004 \
--ram 4096 \
--vcpus 2 \
--disk ${UPPER_DIR}/ubuntu_test.img \
--import \
--os-variant ubuntu20.04 
