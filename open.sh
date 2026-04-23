#!/usr/bin/env bash
set -e

cd $HOME/vm

echo "[+] Starting Debian VM (NO KVM)..."

qemu-system-x86_64 \
  -m 2048 \
  -smp 2 \
  -cpu max \
  -hda disk.img \
  -cdrom debian.iso \
  -boot d \
  -nographic
