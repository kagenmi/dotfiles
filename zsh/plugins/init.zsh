DIR="$ZSH_CONFIG_HOME/plugins"

_zinit_start=$SECONDS
source "$DIR/setup.zsh"
printf "[PROFILE]     setup.zsh (zinit init): %.3fms\n" $((($SECONDS - $_zinit_start) * 1000))

# Be depended on by most themes
_zinit_start=$SECONDS
setopt promptsubst

autoload colors
colors

export ZSH_AUTOSUGGEST_STRATEGY=(history completion match_prev_cmd)
printf "[PROFILE]     zinit config: %.3fms\n" $((($SECONDS - $_zinit_start) * 1000))

# Powerlevel10k removed - migrated to Starship
# zinit lucid light-mode nocd depth=1 \
#   atload"source $ZSH_CONFIG_HOME/plugins/configs/powerlevel10k-atload.zsh" \
#   for '@romkatv/powerlevel10k'

_zinit_start=$SECONDS
zinit wait'0' lucid light-mode for \
    'zsh-users/zsh-completions' \
    'zsh-users/zsh-autosuggestions' \
    'OMZL::git.zsh' \
  atload"unalias grv" \
    'OMZP::git'
printf "[PROFILE]     zinit plugins (wait'0'): %.3fms\n" $((($SECONDS - $_zinit_start) * 1000))

_zinit_start=$SECONDS
zinit wait'0a' lucid light-mode \
  atload'zicompinit; zicdreplay' \
  for \
    'zdharma-continuum/fast-syntax-highlighting' \
    'OMZP::colored-man-pages' \
    'https://github.com/aws/aws-cli/blob/v2/bin/aws_zsh_completer.sh'
printf "[PROFILE]     zinit plugins (wait'0a'): %.3fms\n" $((($SECONDS - $_zinit_start) * 1000))
