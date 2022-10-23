ZSH Config
----------

## Setup

### Symbolic link

Create Symbolic link to `~/.config/zsh`

### Create `~/.zshrc`

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
