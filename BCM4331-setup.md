
# Arch based
## Manjaro
<!-- Blockquote -->
>  Remove network-broadcom-wl if applicable

<!-- Code Blocks -->
```bash
sudo mhwd -r pci network-broadcom-wl
```

>  Rank mirrors and upgrade the system

```bash
sudo pacman-mirrors -f 5 && sudo pacman -Syyu
```

> Then carry on with the rest of the steps normally 

## Artix
> Artix should run artix-pacman-improved.bash before proceeding

## All other arch based
> Upgrade the system (manjaro can skip)

```bash
sudo pacman -Syuu
```

> Then install the linux-headers package for installed kernels 
> (must be run in posix compliant shell or zsh)

```bash
sudo pacman -S $(pacman -Qsq "^linux" | grep "^linux[0-9]*[-rt]*$" | awk '{print $1"-headers"}' ORS=' ')
## Then install the dkms package
```

> Install dkms package

```bash
sudo pacman -S dkms
```

> Reboot, if wifi isn't fixed then carry on with the last step

```bash
sudo pacman -S broadcom-wl-dkms
```

# Debian/Ubuntu based
> Upgrade the system
 
 ```bash
 sudo apt upgrade
```

> Install the linux-headers package for installed kernels

```bash
sudo apt install linux-headers-$(uname -r)
```

> Install the dkms package

```bash
sudo apt install dkms
```

> Reboot, if wifi isn't fixed then carry on with the last step

```bash
sudo apt install broadcom-wl-dkms
```
