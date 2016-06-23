#!/bin/bash

source /tmp/provision/common.sh

yellowprint "\n~~~> Postinstall cleanup steps.\n"

# Swap cleanup.
readonly swapuuid=$(/sbin/blkid -o value -l -s UUID -t TYPE=swap)
readonly swappart=$(readlink -f /dev/disk/by-uuid/"$swapuuid")
/sbin/swapoff "$swappart"
dd if=/dev/zero of="$swappart" bs=1M || echo "dd exit code $? is suppressed"
/sbin/mkswap -U "$swapuuid" "$swappart"

if [ ! "${PACKER_BUILDER_TYPE}" == "qemu" ]; then
  dd if=/dev/zero of=/EMPTY bs=1M
  rm -f /EMPTY
fi
sync

# Remove unnecessary stuff.
yum -y clean all
rm -rf /tmp/provision
rm -rf /var/cache/yum
rm -r /home/vagrant/*.iso
/bin/dd if=/dev/zero of=/boot/EMPTY bs=1M
/bin/rm -f /boot/EMPTY
/bin/dd if=/dev/zero of=/EMPTY bs=1M
/bin/rm -f /EMPTY

sync
