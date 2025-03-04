nvidia-kargs:
  #!/usr/bin/bash
  sudo rpm-ostree kargs \
    --append-if-missing=rd.driver.blacklist=nouveau \
    --append-if-missing=modprobe.blacklist=nouveau \
    --append-if-missing=nvidia-drm.modeset=1 \
    --append-if-missing=nvidia_drm.fbdev=1 \
    --append-if-missing=nvidia.NVreg_EnableGpuFirmware=1 \
    --append-if-missing=nvidia.NVreg_RegistryDwords=EnableBrightnessControl=1 \
    --append-if-missing=nvidia.NVreg_PreserveVideoMemoryAllocations=1 \
    --append-if-missing=nvidia.NVreg_TemporaryFilePath=/var/tmp
