#!/bin/bash
# Script to install BCM4352 wireless card drivers on Pop!_OS

# Ensure the system is updated
sudo apt update
sudo apt upgrade

# Install necessary packages
sudo apt install bcmwl-kernel-source

# Unload conflicting modules
sudo modprobe -r b43 ssb wl brcmfmac brcmsmac bcma

# Load the Broadcom driver
sudo modprobe wl

# Update initramfs
sudo update-initramfs -u

# Reboot the system
sudo reboot
