# qemu-img create -f qcow2 /home/gfigueira/qcows/openbsd63_disk1.qcow 6G
virt-install \
  --name "OpenBSD63" \
  --description "OpenBSD 6.3" \
  --ram=512 \
  --vcpus=1 \
  --disk /home/gfigueira/qcows/openbsd63_disk1.qcow \
  --graphics vnc,password=openbsd,listen=0.0.0.0,port=5963 \
  --cdrom /home/gfigueira/install63.iso \
  --network default
