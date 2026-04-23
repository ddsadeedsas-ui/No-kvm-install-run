#!/usr/bin/env bash
set -e

echo "[+] Installing QEMU + tools..."
apt update -y
apt install -y qemu-system-x86 qemu-utils wget curl

echo "[+] Creating workspace..."
mkdir -p $HOME/vm && cd $HOME/vm

echo "[+] Downloading Debian ISO..."
wget -O debian.iso https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.5.0-amd64-netinst.iso

echo "[+] Creating disk..."
qemu-img create -f qcow2 disk.img 20G

echo "[✓] Install ready!"
echo "Run: ./open.sh"
