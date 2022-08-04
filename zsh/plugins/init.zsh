DIR="$ZSH_CONFIG_HOME/plugins"
source "$DIR/zinit.zsh"

# Be depended on by most themes
setopt promptsubst

autoload colors
colors

export ZSH_AUTOSUGGEST_STRATEGY=(history completion match_prev_cmd)
export NVM_AUTO_LOAD=true
export NVM_COMPLETION=true

zinit depth'1' light-mode for \
    romkatv/powerlevel10k

zinit wait lucid light-mode for \
    'zsh-users/zsh-completions' \
    'zsh-users/zsh-autosuggestions' \
    'OMZL::git.zsh' \
    'mattberther/zsh-pyenv' \
  atload"unalias grv" \
    'OMZP::git' \
  atload'zicompinit; zicdreplay' \
    'lukechilds/zsh-nvm' \
    https://github.com/aws/aws-cli/blob/v2/bin/aws_zsh_completer.sh \
  atinit'zicompinit; zicdreplay' \
    'zdharma-continuum/fast-syntax-highlighting' \
    'OMZP::colored-man-pages' \
  as'completion' \
    OMZP::docker/_docker