if [[ ! $(command -v uv) ]]; then
  if [[ $(command -v curl) ]]; then
    curl -LsSf https://astral.sh/uv/install.sh | sh
  else
    echo '`uv` has not been installed yet. But install process needs `curl`' 1>&2
    return 1
  fi
fi
