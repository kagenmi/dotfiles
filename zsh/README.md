ZSH Config
----------

## Setup

### 0. Change the shell to ZSH

If your current shell is not ZSH, execute below.
```shell
# [Amazon Linux only] install chsh
sudo yum -y install util-linux-user

chsh -s /bin/zsh
```

### 1. Symbolic link

Create Symbolic link to `~/.config/zsh`

### 2. Create `~/.zshrc`

Creaet `~/.zshrc` with the following contents:

```shell
export ZSH_CONFIG_HOME=$HOME/.config/zsh

# Your PATHs
# e.g.:
# PATH=$HOME/.homebrew/bin:$PATH
# HOMEBREW_CACHE=$HOME/.homebrew/cache

source "$ZSH_CONFIG_HOME/zshrc.zsh"
```

### Install Dependencies for `pyenv`

Refer to [this guide](https://github.com/pyenv/pyenv/wiki#suggested-build-environment).
