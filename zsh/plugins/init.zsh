DIR="$ZSH_CONFIG_HOME/plugins"
source "$DIR/zinit.zsh"

# Be depended on by most themes
setopt promptsubst

autoload colors
colors

export ZSH_AUTOSUGGEST_STRATEGY=(history completion match_prev_cmd)
export NVM_AUTO_LOAD=true
export NVM_COMPLETION=false

zinit depth'1' light-mode for \
    romkatv/powerlevel10k

zinit wait lucid light-mode for \
    'zsh-users/zsh-completions' \
    'zsh-users/zsh-autosuggestions' \
    'OMZL::git.zsh' \
    'mattberther/zsh-pyenv' \
    'cda0/zsh-tfenv' \
    'zsh-users/zsh-syntax-highlighting' \
  atload"unalias grv" \
    'OMZP::git' \
  atload'zicompinit; zicdreplay' \
    'lukechilds/zsh-nvm' \
    'unixorn/zsh-gvm' \
    https://github.com/aws/aws-cli/blob/v2/bin/aws_zsh_completer.sh \
  atinit'zicompinit; zicdreplay' \
    'zdharma-continuum/fast-syntax-highlighting' \
    'OMZP::colored-man-pages'
