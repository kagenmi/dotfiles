is-wsl() {
  if [[ -f /proc/version ]]; then
    grep -q microsoft /proc/version
  else
    false
  fi
}

is-mac() {
  [[ "$(uname)" == 'Darwin' ]]
}

# prevent from duplication
add-path() {
    IFS=':' pathes=($(echo $PATH))
    printf '%s\n' ${pathes[@]} | grep "^$1$" &> /dev/null || export PATH=$1:$PATH
}
