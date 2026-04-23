#!/usr/bin/env bash

clear
echo "=============================="
echo "   QEMU VM MANAGER"
echo "=============================="
echo "1) Install VM"
echo "2) Start VM"
echo "3) Loop VM"
echo "4) Exit"
echo "=============================="

read -p "Enter choice: " c

case $c in
  1)
    bash install.sh
    ;;
  2)
    bash open.sh
    ;;
  3)
    bash loop.sh
    ;;
  4)
    exit
    ;;
  *)
    echo "Invalid option"
    ;;
esac
