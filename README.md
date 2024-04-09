# Set up personal workflow

## Install packages

### Packages

```shell
sudo pacman -S git stow unzip nodejs npm zsh alacritty tmux neovim neofetch ripgrep fd fzf lazygit
```

### Nerd Fonts

- [Main Page](https://www.nerdfonts.com)

- [Git Release](https://github.com/ryanoasis/nerd-fonts/releases)

- Hack fonts installation

```shell
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.0/Hack.zip
unzip -q Hack.zip -d Hack
sudo cp -r Hack /usr/share/fonts
```

### [Oh-my-zsh](https://ohmyz.sh/)

- Install with `curl`;

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

- Plugins:

  - [Syntax highlighting](https://github.com/zsh-users/zsh-syntax-highlighting):

  ```shell
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  ```

  - [Auto suggestions](https://github.com/zsh-users/zsh-syntax-highlighting):

  ```shell
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  ```

### Additional

- [Tpm](https://github.com/tmux-plugins/tpm) Plugins Manager for [Tmux](https://github.com/tmux/tmux)

- [Catppuccin Theme](https://github.com/catppuccin/alacritty) for [Alacritty](https://github.com/alacritty/alacritty)

## Install Dotfiles

### Clone repo

- https:

```shell
git clone https://github.com/dangdd2003/dotfiles.git ~/dotfiles
```

- ssh:

```shell
git clone git@github.com:dangdd2003/dotfiles.git ~/dotfiles
```

### Link configuration file

- Link only config file must create parent folder first:

```shell
mkdir ~/.config/alacritty
mkdir ~/.config/tmux
mkdir ~/.config/neofetch
```

- Use GNU Stow to link file;

```shell
cd ~/dotfiles
stow .
```
