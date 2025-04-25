#!/usr/bin/env bash

set -euoxv pipefail

sed -i 's/enabled=0/enabled=1/' /etc/yum.repos.d/negativo17-*.repo

curl -Lo /tmp/install-kernel-akmods.sh https://github.com/ublue-os/bluefin/blob/main/build_files/base/03-install-kernel-akmods.sh

chmod +x /tmp/install-kernel-akmods.sh

BASE_IMAGE_NAME="silverblue" UBLUE_IMAGE_TAG="42" RPMFUSION_MIRROR="" AKMODS_FLAVOR="main" KERNEL="42-6.14.2-300" /tmp/install-kernel-akmods.sh

sed -i 's/enabled=1/enabled=0/' /etc/yum.repos.d/negativo17-*.repo
