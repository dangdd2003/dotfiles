# Set up personal workflow

## Install packages

### Packages

```bash
sudo pacman -S git stow unzip nodejs npm zsh alacritty tmux neovim neofetch ripgrep fd fzf lazygit
```

### Nerd Fonts

- [Main Page](https://www.nerdfonts.com)

- [Git Release](https://github.com/ryanoasis/nerd-fonts/releases)

- Hack fonts installation

```bash
sudo pacman -S ttf-hack-nerd
```

- [Apple Emoji Fonts](https://github.com/samuelngs/apple-emoji-linux)

```bash
wget https://github.com/samuelngs/apple-emoji-linux/releases/download/v17.4/AppleColorEmoji.ttf -P ~/.local/share/fonts
```

### [Oh-my-zsh](https://ohmyz.sh/)

- Install with `curl`;

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

- Plugins:

  - [Syntax highlighting](https://github.com/zsh-users/zsh-syntax-highlighting):

  ```bash
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  ```

  - [Auto suggestions](https://github.com/zsh-users/zsh-syntax-highlighting):

  ```bash
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
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
git clone https://github.com/dangdd2003/dotfiles.git ~/dotfiles
```

- ssh (developer):

```bash
git clone git@github.com:dangdd2003/dotfiles.git ~/dotfiles
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
