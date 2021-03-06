#!/bin/bash

source /tmp/provision/common.sh

yellowprint "\n~~~> Installing Virtualbox Guest Additions.\n"

case "$PACKER_BUILDER_TYPE" in
virtualbox-iso|virtualbox-ovf)
	mkdir /tmp/isomount
	mount -t iso9660 -o loop /home/vagrant/VBoxGuestAdditions.iso /tmp/isomount
	cd /tmp/isomount
	./VBoxLinuxAdditions.run --nox11 || true
	cd /tmp
	umount /tmp/isomount
	rm -rf /tmp/isomount
	yum remove -y gcc bzip2 kernel-ml-devel kernel-ml-headers dkms make perl
	yum -y clean all
	;;
*)
  echo "Unknown Packer Builder Type ${PACKER_BUILDER_TYPE} selected."
  echo "Known are virtualbox-iso|virtualbox-ovf."
  ;;
esac
