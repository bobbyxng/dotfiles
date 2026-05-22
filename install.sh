#!/bin/bash
read -p "This will set up your system. Continue? (y/N) " confirm
[[ $confirm == [yY] ]] || exit 1

# vscode repo
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

# install rpm-ostree packages
rpm-ostree install code zsh gnome-tweaks solaar stow

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# brew packages (includes vscode extensions and flatpaks)
brew bundle install --file=~/dotfiles/Brewfile

# pixi
curl -fsSL https://pixi.sh/install.sh | bash

# claude code
curl -fsSL https://claude.ai/install.sh | bash

# dotfiles
cd ~/dotfiles
stow bash zsh starship vscode git

echo "Done! Reboot to apply rpm-ostree changes."
