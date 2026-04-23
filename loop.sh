#!/usr/bin/env bash
set -e

while true; do
  echo "[+] Starting VM..."
  ./open.sh
  echo "[!] VM stopped — restarting in 10s..."
  sleep 10
done
