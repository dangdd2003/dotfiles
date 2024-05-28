# Set up personal workflow

## Install packages

### Packages

```bash
sudo pacman -S git stow unzip nodejs npm zsh zoxide alacritty tmux neovim neofetch ripgrep fd fzf lazygit
```

### Nerd Fonts

- [Main Page](https://www.nerdfonts.com)

- [Git Release](https://github.com/ryanoasis/nerd-fonts/releases)

- Hack fonts installation

```bash
# Arch Linux
sudo pacman -S ttf-hack-nerd
```

- [Apple Emoji Fonts](https://github.com/samuelngs/apple-emoji-linux)

```bash
wget https://github.com/samuelngs/apple-emoji-linux/releases/download/v17.4/AppleColorEmoji.ttf -P ~/.local/share/fonts
```

### Additional

- [Tpm](https://github.com/tmux-plugins/tpm) Plugins Manager for [Tmux](https://github.com/tmux/tmux)

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

- [Theme](https://github.com/alacritty/alacritty-theme) for [Alacritty](https://alacritty.org)

```bash
mkdir -p ~/.config/alacritty/themes
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
```

## Install Dotfiles

### Clone repo

- https:

```bash
git clone --recurse-submodules https://github.com/dangdd2003/dotfiles.git ~/dotfiles
```

- ssh (developer):

```bash
git clone --recurse-submodules git@github.com:dangdd2003/dotfiles.git ~/dotfiles
```

### Link configuration file

- Linking only config file must create parent folder first:

```bash
mkdir ~/.config/alacritty
mkdir ~/.config/tmux
mkdir ~/.config/neofetch
```

- Use GNU Stow to link file:

```bash
cd ~/dotfiles
stow .
```
