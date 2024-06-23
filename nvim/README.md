# NvChad Config

## Install Neovim

[Releases - neovim/neovim](https://github.com/neovim/neovim/releases)

```shell
wget $appimage_dl_link
chmod u+x nvim.appimage

# If your system has FUSE
mv nvim.appimage ~/.local/bin/nvim

# else if no FUSE
./nvim.appimage --appimage-extract # `squash-root` is ouput
cp ./squash-root/usr/bin/* ~/.local/bin
cp ./squash-root/usr/lib/* ~/.local/lib
cp ./squash-root/usr/man/* ~/.local/man
cp ./squash-root/usr/share/* ~/.local/share
```

## Setup

### 1. Install neovim

Neovim 0.1.0+ is required.

#### MacOS

```shell
brew neovim
```

### 2. Symbolic link the custom config

```shell
ln -s <dotfile dir>/nvim ~/.config/nvim
```
