#!/bin/bash
read -p "This will set up your system. Continue? (y/N) " confirm
[[ $confirm == [yY] ]] || exit 1

# vscode repo
if [ ! -f /etc/yum.repos.d/vscode.repo ]; then
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    echo "VSCode repo added."
else
    echo "VSCode repo already exists, skipping."
fi

# install rpm-ostree packages
rpm-ostree install --idempotent code zsh gnome-tweaks solaar stow fastfetch

# homebrew
if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew already installed, skipping."
fi

# brew packages (includes vscode extensions and flatpaks)
brew bundle install --file=~/dotfiles/Brewfile

# pixi
if ! command -v pixi &>/dev/null; then
    curl -fsSL https://pixi.sh/install.sh | bash
else
    echo "Pixi already installed, skipping."
fi

# claude code
if ! command -v claude &>/dev/null; then
    curl -fsSL https://claude.ai/install.sh | bash
else
    echo "Claude Code already installed, skipping."
fi

# gurobi
GUROBI_VERSION="13.0.2"
GUROBI_SHORT="1302"
GUROBI_DIR="$HOME/gurobi/gurobi${GUROBI_SHORT}/linux64"
GUROBI_TAR="gurobi${GUROBI_VERSION}_linux64.tar.gz"
GUROBI_URL="https://packages.gurobi.com/${GUROBI_VERSION%.*}/gurobi${GUROBI_VERSION}_linux64.tar.gz"

if [ ! -d "$GUROBI_DIR" ]; then
    if [ ! -f "$HOME/$GUROBI_TAR" ]; then
        echo "Downloading Gurobi ${GUROBI_VERSION}..."
        curl -L "$GUROBI_URL" -o "$HOME/$GUROBI_TAR"
    else
        echo "Gurobi tarball already downloaded, skipping download."
    fi
    mkdir -p ~/gurobi
    tar -xzf "$HOME/$GUROBI_TAR" -C ~/gurobi
    echo "Gurobi extracted."
else
    echo "Gurobi already installed, skipping."
fi

# dotfiles
cd ~/dotfiles
stow --adopt bash zsh starship vscode git

echo "Done! Reboot to apply rpm-ostree changes."
