sudo pacman-mirrors -f 5 && sudo pacman -Syyu &&
sudo pacman -S $(pacman -Qsq "^linux" | grep "^linux[0-9]*[-rt]*$" | awk '{print $1"-headers"}' ORS=' ') &&
sudo pacman -S dkms &&
sudo pacman -S broadcom-wl-dkms &&
sudo reboot
