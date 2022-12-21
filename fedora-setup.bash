#!/bin/bash

# Rank and update the mirrors based on speed
dnf config-manager --set-enabled PowerTools && \
dnf install reflector -y && \
reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist && \

# Ask if the desktop environment is gnome or kde
echo "Is your desktop environment gnome or kde based (does it use the gtk toolkit or the qt toolkit)?"
read answer

# Install guake or yakuake depending on the answer
if [ "$answer" == "gnome" ]; then
  sudo dnf install guake -y && \
elif [ "$answer" == "kde" ]; then
  sudo dnf install yakuake -y && \
else
  echo "Answer must be kde or gnome"
  exit 1
fi

# Install the specified packages
sudo dnf install firefox aria2 yt-dlp flatpak python3 rust libreoffice btop neofetch lsd git nano f ish -y && \

# Add the flathub repository if it is not already added
if ! flatpak remote-list | grep -q "flathub"; then
  flatpak remote-add flathub https://flathub.org/repo/flathub.flatpakrepo && \
fi

# Install the specified flatpaks if they are not already installed
flatpaks=(com.visualstudio.code net.runelite.RuneLite)
for flatpak in "${flatpaks[@]}"; do
  if ! flatpak list --app "$flatpak" &> /dev/null; then
    flatpak install "$flatpak" -y && \
  fi
done

# Download and install the SourceCodePro font
aria2c -s16 -x16 -j16 -k1M https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/SourceCodePro.zip && \
unzip -q -o SourceCodePro.zip && \
mv SourceCodePro.zip /usr/share/fonts && \
rm SourceCodePro.zip && \
fc-cache -fv && \

# Change the user shell to fish
chsh -s /usr/bin/fish && \

# Invoke the fish shell and install oh-my-fish and the agnoster theme
fish -c "
  curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > install
  fish install --path=~/.local/share/omf --config=~/.config/omf
  omf install agnoster
" && \

# Log the user out
logout
