# dotfiles

Personal dotfiles for Fedora Silverblue, managed with GNU Stow.

## Structure

- `bash/` — `.bashrc`
- `zsh/` — `.zshrc` (autosuggestions, syntax-highlighting, starship)
- `starship/` — `~/.config/starship.toml`
- `vscode/` — `~/.config/Code/User/settings.json`
- `git/` — `.gitconfig`
- `brew/` — `Brewfile` (brew, VS Code extensions, Flatpaks)

## Fresh machine setup

1. Install Fedora Silverblue
2. Clone this repo:
```bash
   git clone git@github.com:bobbyxng/dotfiles.git ~/dotfiles
```
3. Run install script:
```bash
   cd ~/dotfiles
   bash install.sh
```
4. Reboot to apply rpm-ostree changes
5. Apply stow symlinks:
```bash
   cd ~/dotfiles
   stow bash zsh starship vscode git
```

## Adding new dotfiles

```bash
mv ~/.config/something ~/dotfiles/appname/.config/something
cd ~/dotfiles
stow appname
git add .
git commit -m "add appname config"
git push
```
