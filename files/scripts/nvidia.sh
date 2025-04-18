#!/usr/bin/env bash

set -euoxv pipefail

sed -i 's/enabled=0/enabled=1/' /etc/yum.repos.d/negativo17-*.repo

dnf5 install -y /tmp/akmods-rpms/ublue-os/ublue-os-nvidia*.rpm
dnf5 install -y /tmp/akmods-rpms/kmods/kmod-nvidia*.rpm

# Install Nvidia RPMs
curl -Lo /tmp/nvidia-install.sh https://raw.githubusercontent.com/ublue-os/hwe/main/nvidia-install.sh # Change when nvidia-install.sh updates
chmod +x /tmp/nvidia-install.sh
IMAGE_NAME="silverblue" RPMFUSION_MIRROR="" /tmp/nvidia-install.sh
rm -f /usr/share/vulkan/icd.d/nouveau_icd.*.json
ln -sf libnvidia-ml.so.1 /usr/lib64/libnvidia-ml.so

sed -i 's/enabled=1/enabled=0/' /etc/yum.repos.d/negativo17-*.repo
