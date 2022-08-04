is-wsl() {
  grep -q microsoft /proc/version
}

is-mac() {
  [[ "$(uname)" == 'Darwin' ]]
}

# prevent from duplication
add-path() {
    IFS=':' pathes=($(echo $PATH))
    printf '%s\n' ${pathes[@]} | grep "^$1$" &> /dev/null || export PATH=$1:$PATH
}
