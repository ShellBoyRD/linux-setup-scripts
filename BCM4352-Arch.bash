#!/bin/bash
# Script to install BCM4352 wireless card drivers on Arch-based distros using broadcom-wl-dkms

# Ensure the system is updated
sudo pacman -Syu

# Install necessary packages
sudo pacman -S broadcom-wl-dkms

# Unload conflicting modules
sudo modprobe -r b43 ssb wl brcmfmac brcmsmac bcma

# Load the Broadcom driver
sudo modprobe broadcom-wl-dkms

# Reboot the system
sudo reboot
