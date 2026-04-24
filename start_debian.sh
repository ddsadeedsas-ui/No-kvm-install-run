#!/bin/bash

# 1. Download official Debian 13 (Trixie) Generic Cloud Image
IMAGE_URL="https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-13.4.0-amd64-netinst.iso"

if [ ! -f "debian13.qcow2" ]; then
    echo "Downloading Debian 13 Cloud Image..."
    wget -O debian13.qcow2 "$IMAGE_URL"
    # Resize to give the OS more room (10G additional)
    qemu-img resize debian13.qcow2 +10G
fi

# 2. Create Cloud-Init configuration
# user-data: Sets user 'debian' with password 'debian'
cat <<EOF > user-data
#cloud-config
user: debian
password: debian
chpasswd: { expire: False }
ssh_pwauth: True
EOF

# meta-data: Sets the internal hostname
cat <<EOF > meta-data
local-hostname: debian-vm
instance-id: i-$(date +%s)
EOF

# Create the seed ISO image (standard NoCloud datasource for QEMU)
cloud-localds seed.img user-data meta-data

# 3. Launch QEMU
# -m 2G: Allocates 2GB RAM
# -net user,hostfwd=...: Maps VM port 22 to Host port 2222
# -nographic: Required for terminal-only environments like Hugging Face
qemu-system-x86_64 \
    -m 2G \
    -drive file=debian13.qcow2,if=virtio \
    -drive file=seed.img,if=virtio,format=raw \
    -net nic -net user,hostfwd=tcp::2222-:22 \
    -nographic \
    -machine accel=tcg
