# NvChad Config

## Setup

### 1. Install `neovim`

Neovim 0.8.0+ is required.

#### MacOS

```shell
brew neovim
```

### 2. Install NvChad

ref. [NvChad Doc - Install](https://nvchad.com/quickstart/install#pre-requisites)
```shell
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
```

### 3. Symbolic link the custom config

```shell
ln -s <dotfile dir>/nvchad/custom ~/.config/nvim/lua
```
