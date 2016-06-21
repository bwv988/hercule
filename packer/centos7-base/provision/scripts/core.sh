#!/bin/bash

source /tmp/provision/common.sh

yellowprint "\n~~~> Installing core packages.\n"

yum update -y
yum -y install mc
yum -y install wget
