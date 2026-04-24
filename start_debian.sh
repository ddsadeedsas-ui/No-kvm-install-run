#!/bin/bash

# 1. Download Debian 13 (Testing) Cloud Image if not exists
if [ ! -f "debian13.qcow2" ]; then
    wget -O debian13.qcow2 https://debian.org
    qemu-img resize debian13.qcow2 +10G
fi

# 2. Create basic Cloud-Init to set password (user: debian, pass: debian)
cat <<EOF > user-data
#cloud-config
password: debian
chpasswd: { expire: False }
ssh_pwauth: True
EOF
cloud-localds seed.img user-data

# 3. Launch QEMU (using -nographic for container compatibility)
# We map SSH port 22 to 2222 so you can access it from code-server terminal
qemu-system-x86_64 \
    -m 2G \
    -drive file=debian13.qcow2,if=virtio \
    -drive file=seed.img,if=virtio,format=raw \
    -net nic -net user,hostfwd=tcp::2222-:22 \
    -nographic
