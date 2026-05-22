# homebrew
if [ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# pixi
export PATH="$HOME/.pixi/bin:$PATH"

# local bin
export PATH="$HOME/.local/bin:$PATH"

# history
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
zshaddhistory() {
  whence ${${(z)1}[1]} >| /dev/null || return 1
}

# zsh plugins
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Gurobi
export GUROBI_HOME="$(echo $HOME/gurobi/gurobi*/linux64 | tr ' ' '\n' | sort -V | tail -1)"
if [ -d "$GUROBI_HOME" ]; then
    export PATH="$PATH:$GUROBI_HOME/bin"
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$GUROBI_HOME/lib"
fi

# TUB openconnect VPN
alias tuvpn-split='pixi run --manifest-path $HOME/tuvpn/pixi.toml tuvpn-split'
alias tuvpn-full='pixi run --manifest-path $HOME/tuvpn/pixi.toml tuvpn-full'

# starship
eval "$(starship init zsh)"
