# Archlinux installation

Minimal archlinux installation for most users.

## 1. Pre-installation

### 1.1 Download required file

Download these file from <a target="blank" href="https://archlinux.org/download">Download</a> page.

Required:

- `archlinux-<version>-x86_64.iso` - ISO image.

Optional (for verification):

- `archlinux-<version>-x86_64.iso.sig` - Signature of ISO image.

- `b2sums.txt` - verify integrity of the image.

- `sha256sums.txt` - verify integrity of the image.

### 1.2. Verify ISO image (Optional)

Verify BLAKE2b sum of the ISO image.

```bash
b2sum -c b2sums.txt
```

Verify SHA256 sum of the image.

```bash
sha256sums -c sha256sums.txt
```

Download signing key for verifying the signature.

Requirement: <a href="https://gnupg.org" target="blank">GnuPG</a>.

```bash
gpg --auto-key-locate clear,wkd -v --locate-external-key pierre@archlinux.org
```

Verify the signature.

```bash
gpg --keyserver-options auto-key-retrieve --verify archlinux-<version>-x86_64.iso.sig archlinux-<version>-x86_64.iso
```

> [!TIP]
> Verify the signature is not required but for security reason.

### 1.3. Create the installation medium

Window: Use <a href="https://rufus.ie" target="blank">Rufus</a>.

Linux/MacOS:

```bash
sudo dd if=/path/to/archlinux-<version>-x86_64.iso of=/dev/<disk name> bs=4M status=progess
```

Or use any other 3rd-party tool that can flash the installer to the USB.

> [!CAUTION]
> Be careful before destroying important disk.

### 1.4. Boot the live environment

> [!NOTE]
> Archlinux installation images do not support Secure Boot, so it must be disable. Enable it latter if needed.

### 1.5. Setup network

> [!NOTE]
> Wired connection can skip this step.

For wifi setup, first enter _iwctl_ environment.

```bash
iwctl
```

Check the name of wireless devices.

```bash
device list
```

Connect to wifi where **SSID** is the name of wireless device.

```bash
station wlan0 connect <SSID>
```

Enter the password if it requires.

Exit _iwctl_ environment.

```bash
exit
```

Check the connection via one of these commands.

```bash
ip a
ping dangdd.me
ping google.com
ping archlinux.org
```

### 1.6. SSH Connection

Enable _sshd_ service (should be done by default).

```bash
systemctl start sshd
```

Set password for current user.

```bash
passwd
```

Connect from other devices (Should be the same network connection. For different
network connection, port must be exposed to the world wide).

```bash
ssh root@<ip of local machine>
```

Enter password.

### 1.7. Disk partitioning

Get the name of blocks.

```bash
lsblk
```

Multiple tool used for partitioning, this setup will use `cfdisk`.

```bash
cfdisk /dev/nvme0n1 # or /dev/sda1 - depend on name of main block
```

Recommend to create 1GB of EFI (for NVIDIA kernel settings)

Swap is optional for performance. Should be at least 2GB.

Remainder of the disk. Should be at least 20GB.

| Mount point | Partition      | Partition type       | Size          |
| ----------- | -------------- | -------------------- | ------------- |
| /boot       | /dev/nvme0n1p1 | EFI system partition | 1GB           |
| [SWAP]      | /dev/nvme0n1p2 | Linix swap           | At least 2GB  |
| /           | /dev/nvme0n1p3 | Linux file system    | At least 20GB |

Depend on requirement for partitioning. Make sure to mount to right folder for
installation latter on.

### 1.8. Format the partition

Format FAT32 on EFI system partition

```bash
mkfs.fat -F 32 /dev/nvme0n1p1
```

If use swap, enable swap partition.

```bash
mkswap /dev/nvme0n1p2
```

Format root partition.

```bash
mkfs.ext4 /dev/nvme0n1p3
```

Partitions other than EFI and Swap should be formatted with EXT4.

### 1.9. Mount the file systems

Mount root partition.

```bash
mount /dev/nvme0n1p3 /mnt
```

Mount EFI partition to boot

> [!TIP]
> Use `--mkdir` option to create the folder for specific mount point.

```bash
mount --mkdir /dev/nvme0n1p1 /mnt/boot
```

If use other partitions, they should be mount same as `/boot`. For example,
partition /dev/nvme0n1p4 is used for `/home` mount point.

```bash
mount --mkdir /dev/nvme0n1p4 /mnt/home
```

If use swap, turn on the swap.

```bash
swapon /dev/nvme0n1p2
```

## 2. Install Arch

Normal installation.

```bash
packstrap -K /mnt base linux linux-firmware
```

Advanced installation for development.

```bash
packstrap -K /mnt base base-devel linux linux-firmware
```

## 3. System configuration

### 3.1. Generate fstab file table

```bash
genfstab -U /mnt > /mnt/etc/fstab
```

### 3.2. Chroot into new installed system

```bash
arch-chroot /mnt
```

### 3.3. Install additional packages, tools

```bash
pacman -S neovim fastfetch
```

### 3.4. Time

Set timezone

```bash
ln -sf /usr/share/zoneinfo/<Region>/<City> /etc/localtime
```

Generate hardware clock to `/etc/adjtime`

```bash
hwclock --systohc
```

### 3.5. Locale

Uncomment `en_US.UTF-8 UTF-8` and other needed UTF-8 locales.

```bash
nvim /etc/locale.gen
```

Generate locales

```bash
locage-gen
```

Create new file to set desired UTF-8 Lang `LANG=en_US.UTF-8`.

```bash
nvim /etc/locale.conf
```

### 3.6. Hostname

Create new file and enter hostname.

```bash
nvim /etc/hostname
```

or

```bash
echo "<hostname>" > /etc/hostname
```

### 3.7. Users

Set password for root user.

```bash
passwd
```

Install desired shell (Optional).

```bash
pacman -S zsh
```

Add normal user with full access to all system.

```bash
useradd -m -G wheel users power storage audio video -s /bin/zsh <username>
```

Set the password for new user.

```bash
passwd <username>
```

Add _wheel_ group to sudoers.

```bash
EDITOR=nvim visudo
```

Uncomment

```bash
%wheel ALL=(ALL:ALL) ALL
```

### 3.8. Network & Bluetooth

Install packages.

```bash
pacman -S networkmanager bluez bluez-utils
```

For graphical application, visit <a href="https://wiki.archlinux.org/title/NetworkManager#Front-ends" target="blank">Network</a>
and <a href="https://wiki.archlinux.org/title/Bluetooth#Graphical" target="blank">Bluetooth</a> wiki pages.

Enable background services.

```bash
systemctl enable NetworkManager.service # Case sensitive
systemctl enable bluetooth.service
```

### 3.9. Microcode

Required for stability between cpu and system.

For AMD processors.

```bash
pacman -S amd-ucode
```

For Intel processors.

```bash
pacman -S intel-ucode
```

## 4. GRUB Bootloader

Install _grub_ and _efibootmgr_.

```bash
pacman -S grub efibootmgr
```

Setup grub on EFI partition.

```bash
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
```

### 4.1. Dualboot

Install _os-prober_ for detecting multiple OS.

```bash
pacman -S os-prober ntfs-3g # for windows
```

Get the **UUID** of the other OS partitions/disks

```bash
blkid
```

For auto mounting at start up, add entries to `/etc/fstab` file.
For example "Windows 11" with **UUID**=E248DF2448DEF66F.

```bash
# Windows 11
UUID=E248DF2448DEF66F    /media/Windows\04011    ntfs-3g    defaults    0    1
# \040 add space between "Windows" and "11"
```

More information on <a href="https://wiki.archlinux.org/title/Fstab" target="blank">fstab</a> site.

Enable OS Prober in GRUB.

```bash
nvim /etc/default/grub
```

Uncomment (bottom of file)

```bash
GRUB_DISABLE_OS_PROBER=false
```

### 4.2. Make grub config

```bash
grub-mkconfig -o /boot/grub/grub.cfg
```

## 5. Reboot to system

```bash
exit
umount -R /mnt
reboot now
```

## 6. Additional setup

### 6.1. <a href="https://github.com/Jguer/yay" target="blank">Yay</a> - AUR helper

```bash
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

# Hyprland desktop environment

Multiple DE can be installed via full guide on Archlinux wiki <a href="https://wiki.archlinux.org/title/Desktop_environment" target="blank">page</a>.

This page shows the setup for <a href="https://hyprland.org" target="blank">Hyprland</a> with the aim of minimalism and stability.

(After logging in from minimal arch install)

## 1. Hyprland setup

### 1.1. Hyprland and Hypr Ecosystem

```bash
sudo pacman -Syu hyprland hyprpaper hyprcursor hypridle hyprlock hyprpicker xdg-desktop-portal-hyprland
```

More details on Hyprland ecosystem wiki <a href="https://wiki.hyprland.org/Hypr-Ecosystem" target="blank">page</a>.

### 1.2. <a href="https://wiki.archlinux.org/title/SDDM" target="blank">SDDM</a> display manager

```bash
sudo pacman -S sddm
```

## 2. Additional utilities

### 2.1. <a href="https://github.com/Alexays/Waybar" target="blank">Waybar</a> - Status bar

```bash
sudo pacman -S waybar
```

### 2.2. <a href="https://github.com/ArtsyMacaw/wlogout" target="blank">Wlogout</a> - Logout manager

```bash
yay -S wlogout
```

### 2.3. <a href="https://github.com/dunst-project/dunst" target="blank">Dunst</a> - Notification daemon

```bash
sudo pacman -S dunst
```

### 2.4. Sound system

Only _pipewire_ and _wireplumber_ are used for minimalism.

```bash
sudo pacman -S pipewire wireplumber pipewire-alsa
```

_pipewire-alsa_ provides sound support for application using ALSA (e.g. Spotify).

When install Firefox, use _pipewire-jack_.

Install sound, media controller.

```bash
sudo pacman -S playerctl
yay -S pwvucontrol
```

### 2.5. Brightness (Laptop)

```bash
sudo pacman -S brightnessctl
```

## 3. Personal stuffs (Optional)

### 3.1. Packages

```bash
sudo pacman -S git stow unzip nodejs npm zsh zoxide alacritty tmux ripgrep fd fzf lazygit firefox
yay -S spotify vesktop
```

### 3.2. Nerd fonts

- <a href="https://www.nerdfonts.com" target="blank">Main page</a>.

- <a href="https://github.com/ryanoasis/nerd-fonts/releases" target="blank">Git release</a>.

```bash
sudo pacman -S ttf-ibmplex-mono-nerd ttf-jetbrains-mono-nerd ttf-hack-nerd
```

- <a href="https://github.com/samuelngs/apple-emoji-linux" target="blank">Apple Emoji Fonts</a>.

```bash
wget https://github.com/samuelngs/apple-emoji-linux/releases/download/v17.4/AppleColorEmoji.ttf -P ~/.local/share/fonts
```

### 3.3. Additional

<a href="https://github.com/tmux-plugins/tpm" target="blank">Tpm</a> tmux plugins manager.

```bash
mkdir -p ~/.config/tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

Alacritty <a href="https://github.com/alacritty/alacritty-theme" target="blank">themes</a>.

```bash
mkdir -p ~/.config/alacritty/themes
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
```

### 3.4. Dotfiles

Clone repo.

```bash
# https
git clone --recurse-submodules https://github.com/dangdd2003/dotfiles.git ~/.dotfiles
# ssh
git clone --recurse-submodules git@github.com:dangdd2003/dotfiles.git ~/.dotfiles
```

> [!TIP]
> Create the parent folder before using `stow` keeps source repo not to add additional user created files
> in linked folders.
>
> ```bash
> mkdir -p ~/.config/oh-my-posh
> mkdir -p ~/.config/hypr
> mkdir -p ~/.config/waybar
> mkdir -p ~/.config/rofi
> mkdir -p ~/.config/wlogout
> ```

Link config file.

```bash
cd ~/.dotfiles
stow .
```

### 3.5. Theme

Catppuccin <a href="https://catppuccin.com/ports" target="blank">ports</a>.

- Hyprland
- Waybar
- Hyprlock
- Rofi
- GTK Application
- SDDM
- GRUB

Banana-Catppuccin-Machiato cursors.

## 4. Reboot

```bash
sudo reboot now
```

# NVIDIA proprietary drivers configuration

## 1. Install NVIDIA drivers and required packages

Get information of GPU.

```bash
lspci -k | grep -A 2 -E "(VGA|3D)"
```

Check for appropriate driver in table on NVIDIA Arch
<a href="https://wiki.archlinux.org/title/NVIDIA" target="blank">wiki</a>.

```bash
sudo pacman -S linux-headers nvidia-utils nvidia # <-- install driver base on the table
```

Install graphical settings (optional).

```bash
sudo pacman -S nvidia-settings
```

## 2. DRM kernel mode setting.

> [!NOTE]
> Starting from `nvidia-utils` version 560.35.03-5, DRM kernel mode setting is auto enable.
> This part is for older drivers.

Verify DRM is actually enabled (should return `Y`).

```bash
sudo cat /sys/module/nvidia_drm/parameters/modeset
```

Verify kernel module `modeset`.

```bash
sudo cat /etc/modprobe.d/nvidia.conf
```

Should return `options nvidia_drm modeset=1`

### 2.1. Kernel parameters from bootloader (GRUB)

```bash
sudo nvim /etc/default/grub
```

Add `nvidia-drm.modeset=1` and `nvidia-drm.fbdev=1` to grub configuration.

```conf
# Linux kernel 6.11 or newer
# /etc/default/grub
GRUB_CMDLINE_LINUX_DEFAULT=" ...<other>.. nvidia-drm.modeset=1 nvidia-drm.fbdev=1"
```

> [!CAUTION]
> Linux kernel 6.10 or older remove `nvidia-drm.fbdev=1`

### 2.2. Early loading

Add additional kernel parameters `nvidia`, `nvidia_modeset`, `nvidia_uvm`, and `nvidia_drm` to initramfs.

```bash
sudo nvim /etc/mkinitcpio.conf
```

```conf
# /etc/mkinitcpio.conf
MODULES=( ...<other>... nvidia nvidia_modeset nvidia_uvm nvidia_drm)
```

### 2.3. Auto upgrading initramfs

> [!NOTE]
> Dkms `*-dkms` drivers should skip this step as the upgrade will automatically trigger `mkinitcpio`
> run to upgrade initramfs.

Add pacman hook.

```bash
mkdir -p /etc/pacman.d/hooks
sudo nvim /etc/pacman.d/hooks/nvidia.hook
```

Add script to hook file.

```conf
[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
# Get installed NVIDIA driver: pacman -Q | grep nvidia
Target=nvidia
# Get installed Linux kernel: pacman -Q | grep linux
Target=linux

[Action]
Description=Updating NVIDIA module in initcpio
Depends=mkinitcpio
When=PostTransaction
NeedsTargets
Exec=/bin/sh -c 'while read -r trg; do case $trg in linux*) exit 0; esac; done; /usr/bin/mkinitcpio -P'
```

> [!CAUTION]
> Check `Target` part to match the name of installed driver and kernel.
> Normally, the initramfs should be upgraded after new NVIDIA driver and Linux kernel get update.
> This hook will automatically do that.

## 3. NVIDIA settings for Hyprland

### 3.1. System configuration

Enable [[#2.2. Early loading|early loading]] in previous part.

Create or edit file `/etc/modprobe.d/nvidia.conf`.

```bash
sudo nvim /etc/modprobe.d/nvidia.conf
```

Add this line.

```conf
options nvidia_drm modeset=1 fbdev=1
```

Rebuild the initramfs.

```
sudo mkinitcpio -P
```

### 3.2. Environment variables

Add to hyprland configuration `~/.config/hypr/hyprland.conf`.

```conf
env = LIBVA_DRIVER_NAME,nvidia
env = XDG_SESSION_TYPE,wayland
env = GBM_BACKEND,nvidia-drm
env = __GLX_VENDOR_LIBRARY_NAME,nvidia

cursor {
    no_hardware_cursors = true
}
```

### 3.3. Reboot

```bash
sudo reboot now
```

# Troubleshooting

## Rebuild the EFI partition (GRUB Bootloader)

Make an Archlinux USB installer
([[#1.3. Create the installation medium|create the installer]]).

After boot to live environment, recreate new EFI partition and format
with FAT32 if needed.

```bash
cfdisk /dev/<disk>
mkfs.fat -F 32 /dev/<partitions>
```

Remount all system partitions.

```bash
mount --mkdir /dev/<partition> /mnt/<mount point>
```

Generate new fstab file if needed.

> [!NOTE]
> Dualboot should follow the same steps in [[#4.1. Dualboot|installation process]]

```bash
genfstab -U /mnt > /mnt/etc/fstab
```

Chroot into system.

```bash
arch-chroot /mnt
```

Rebuild initramfs

```bash
mkinitcpio -P
```

Reinstall GRUB to EFI partition

```bash
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
```

Regenerate GRUB configuration

```bash
grub-mkconfig -o /boot/grub/grub.cfg
```

Reboot

```bash
exit
umount -R /mnt
reboot now
```
