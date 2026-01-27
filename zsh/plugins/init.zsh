DIR="$ZSH_CONFIG_HOME/plugins"
source "$DIR/setup.zsh"

# Be depended on by most themes
setopt promptsubst

autoload colors
colors

export ZSH_AUTOSUGGEST_STRATEGY=(history completion match_prev_cmd)

# Powerlevel10k removed - migrated to Starship
# zinit lucid light-mode nocd depth=1 \
#   atload"source $ZSH_CONFIG_HOME/plugins/configs/powerlevel10k-atload.zsh" \
#   for '@romkatv/powerlevel10k'

zinit wait'0' lucid light-mode for \
    'zsh-users/zsh-completions' \
    'zsh-users/zsh-autosuggestions' \
    'OMZL::git.zsh' \
  atload"unalias grv" \
    'OMZP::git'

zinit wait'0a' lucid light-mode \
  atload'zicompinit; zicdreplay' \
  for \
    'zdharma-continuum/fast-syntax-highlighting' \
    'OMZP::colored-man-pages' \
    'https://github.com/aws/aws-cli/blob/v2/bin/aws_zsh_completer.sh'
