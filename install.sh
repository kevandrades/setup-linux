#!/bin/bash
set -eo pipefail

has() {
  [[ -x "$(command -v "$1")" ]];
}

has_not() {
  ! has "$1" ;
}

ok() {
  echo "→ "$1" OK"
}

sudo apt-get update
sudo apt-get install -y \
  flameshot \
  neofetch \
  papirus-icon-theme \
  breeze-cursor-theme \
  r-base \
  zsh \
  curl \
  wget \
  git git-core \
  wine \
  playonlinux \
  dconf-editor \
  chromium-browser \
  docker docker-compose \
  htop \
  steam \
  gimp



wget https://code.visualstudio.com/docs/?dv=linux64_deb; 
# Headphone Bluetooth
sudo apt-get install blueman pulseaudio-module-bluetooth
pactl load-module module-bluetooth-discover
echo "Now, open bluetooth settings, and pair your device."
echo "After that, open sound settings and select your device."
echo "On 'profile' entry, choose 'High Fidelity Playback' and we're done."

if has_not pip; then
  sudo apt-get install python-pip python3-dev python3-venv build-essential
  sudo pip install --upgrade pip 
  sudo pip install --upgrade virtualenv
fi
ok "pip"


if ! [[ -d "$HOME/.oh-my-zsh" ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
ok "OH My ZSH"


sudo apt-get autoclean -y
sudo apt-get autoremove -y

ok "Installation finished!"