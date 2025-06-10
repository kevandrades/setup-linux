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
  playonlinux

# Headphone Bluetooth
sudo apt-get install blueman pulseaudio-module-bluetooth
pactl load-module module-bluetooth-discover
echo "Now, open bluetooth settings, and pair your device."
echo "After that, open sound settings and select your device."
echo "On 'profile' entry, choose 'High Fidelity Playback' and we're done."

if has_not pip; then
  sudo apt-get install python-pip python-dev build-essential
  sudo pip install --upgrade pip 
  sudo pip install --upgrade virtualenv
fi
ok "pip"

if has_not chromium-browser; then
  sudo apt install chromium-browser
fi
ok "Chrome"

if has_not docker; then
  sudo apt-get install apt-transport-https ca-certificates linux-image-extra-$(uname -r) -y
  sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
  sudo sh -c "echo 'deb https://apt.dockerproject.org/repo ubuntu-$(lsb_release -sc) main' | cat > /etc/apt/sources.list.d/docker.list"
  sudo apt-get update
  sudo apt-get purge lxc-docker
  sudo apt-get install docker-engine -y
  sudo service docker start
  sudo groupadd docker
  sudo usermod -aG docker $(id -un)
fi
ok "Docker"


if has_not diffmerge; then
  wget -O diffmerge.deb http://download-us.sourcegear.com/DiffMerge/4.2.0/diffmerge_4.2.0.697.stable_amd64.deb
  sudo dpkg -i diffmerge.deb --ignore-depends
  sudo apt-get install -fy
  rm -rf diffmerge.deb
fi
ok "Diffmerge"

if ! [[ -d "$HOME/.oh-my-zsh" ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
ok "OH My ZSH"


sudo apt-get autoclean -y
sudo apt-get autoremove -y

ok "Installation finished!"