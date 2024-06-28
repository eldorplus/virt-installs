#!/bin/bash

VMNAME="kickstart"

virt-install \
--virt-type kvm \
--name=centos8_${VMNAME} \
--os-variant=centos8 \
--cpu host-passthrough \
--vcpus 2 \
--memory 2048 \
--disk path=/kvm/centos8_${VMNAME}.qcow2,size=40,format=qcow2,sparse=true,bus=scsi,discard=unmap \
--controller type=scsi,model=virtio-scsi \
--network bridge=br0,model=virtio \
--channel spicevmc,target_type=virtio,name=com.redhat.spice.0 \
--channel unix,target_type=virtio,name=org.qemu.guest_agent.0 \
--graphics spice,gl.enable=no,listen=none \
--video qxl \
--console pty,target_type=virtio \
--metadata title="CentOS 8.4 (${VMNAME})" \
--location /kvm/CentOS-8.4.2105-x86_64-dvd1.iso \
--extra-args='inst.ks=file:centos8_kickstart.cfg' \
--initrd-inject=centos8_kickstart.cfg \
--noreboot
