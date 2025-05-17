#!/usr/bin/env bash

set -euoxv pipefail

sed -i 's/enabled=0/enabled=1/' /etc/yum.repos.d/negativo17-*.repo
curl -Lo /tmp/install-kernel-akmods.sh https://raw.githubusercontent.com/ublue-os/bluefin/refs/heads/main/build_files/base/03-install-kernel-akmods.sh

chmod +x /tmp/install-kernel-akmods.sh

BASE_IMAGE_NAME="silverblue" UBLUE_IMAGE_TAG="42" RPMFUSION_MIRROR="" AKMODS_FLAVOR="main" KERNEL="6.14.5-300.fc42.x86_64" IMAGE_NAME="silverblue-nvidia" /tmp/install-kernel-akmods.sh

curl -Lo /tmp/initramfs.sh https://raw.githubusercontent.com/ublue-os/bluefin/refs/heads/main/build_files/base/19-initramfs.sh
chmod +x /tmp/initramfs.sh
AKMODS_FLAVOR="main" /tmp/initramfs.sh

sed -i 's/enabled=1/enabled=0/' /etc/yum.repos.d/negativo17-*.repo
