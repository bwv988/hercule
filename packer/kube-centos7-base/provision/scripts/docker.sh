#!/bin/bash

source /tmp/provision/common.sh

yellowprint "\n~~~> Installing and configuring Docker.\n"

yum -y install docker-engine

groupadd docker
usermod -a -G docker vagrant

cat >> /etc/security/limits.conf <<EOF
*        hard    nproc           16384
*        soft    nproc           16384
*        hard    nofile          16384
*        soft    nofile          16384
EOF

systemctl enable docker.service
