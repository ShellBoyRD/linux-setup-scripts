#!/bin/bash

# Check if the fastestmirror option is already set in the dnf.conf file
if grep -q "^fastestmirror" /etc/dnf/dnf.conf; then
  # If the option is already set, edit the value
  sed -i "s/^fastestmirror.*/fastestmirror=1/" /etc/dnf/dnf.conf
else
  # If the option is not set, add it to the bottom of the file
  echo "fastestmirror=1" >> /etc/dnf/dnf.conf
fi

echo "The dnf.conf file has been updated with the fastestmirror option set to 1."

# System update via dnf

sudo dnf upgrade

# Ask the user which desktop environment they are using
read -p "What desktop environment are you using (if Qt-based, say KDE; if GTK-based, say GNOME)? " de

# Install the appropriate terminal emulator
if [ "$de" == "GNOME" ]; then
  sudo dnf install guake
elif [ "$de" == "KDE" ]; then
  sudo dnf install yakuake
else
  echo "Invalid input. Please try again."
fi

# Check if RPM Fusion repository is enabled
if ! dnf repolist enabled | grep -q "rpmfusion-free"; then
  # Enable RPM Fusion repository
  sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
  sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
fi

# Install specified applications using dnf
APPLICATIONS=(firefox aria2 yt-dlp flatpak python3 rust libreoffice btop neofetch lsd git nano vlc fish)
for app in "${APPLICATIONS[@]}"; do
  if ! dnf list installed "$app" &> /dev/null; then
    sudo dnf install -y "$app"
  fi
done

# Add the flathub repository if it is not already added
if ! flatpak remote-list | grep -q "flathub"; then
  flatpak remote-add flathub https://flathub.org/repo/flathub.flatpakrepo
fi

# Install the specified flatpaks if they are not already installed
flatpaks=(com.visualstudio.code net.runelite.RuneLite)
for flatpak in "${flatpaks[@]}"; do
  if ! flatpak list --app "$flatpak" &> /dev/null; then
    flatpak install "$flatpak" -y
  fi
done

# Download and install the SourceCodePro font
aria2c -s16 -x16 -j16 -k1M https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/SourceCodePro.zip
unzip -q -o SourceCodePro.zip
mv SourceCodePro.zip /usr/share/fonts
rm SourceCodePro.zip
fc-cache -fv

# Change the user shell to fish
chsh -s /usr/bin/fish

# Invoke the fish shell and install oh-my-fish and the agnoster theme
fish -c "
  curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > install
  fish install --path=~/.local/share/omf --config=~/.config/omf
  omf install agnoster
"
command
