# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# homebrew
if [ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# pixi
export PATH="$HOME/.pixi/bin:$PATH"

# gurobi
export GUROBI_HOME="$(echo $HOME/gurobi/gurobi*/linux64 | tr ' ' '\n' | sort -V | tail -1)"
if [ -d "$GUROBI_HOME" ]; then
    export PATH="$PATH:$GUROBI_HOME/bin"
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$GUROBI_HOME/lib"
fi

# starship
eval "$(starship init bash)"
export PATH="$HOME/.local/bin:$PATH"
