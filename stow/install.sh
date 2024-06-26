#!/bin/bash

# Load environment variables
source "$(dirname "$0")/../env.sh"

# Paths
STEW_BIN="stew"
CONFIG_DIR="$(dirname "$0")/../stew"

link_stew() {
  local config_file="$1"
  $STEW_BIN link -c "$config_file"
}

unlink_stew() {
  local config_file="$1"
  $STEW_BIN unlink -c "$config_file"
}

deactivate_zsh() {
  mv "$HOME/.zshrc" "$HOME/.zshrc.backup"
  mv "$HOME/.zshenv" "$HOME/.zshenv.backup"
  echo "Zsh configs deactivated. You can start a new terminal with --no-rcs option."
}

reactivate_zsh() {
  mv "$HOME/.zshrc.backup" "$HOME/.zshrc"
  mv "$HOME/.zshenv.backup" "$HOME/.zshenv"
  echo "Zsh configs reactivated."
}

case "$1" in
  link)
    link_stew "$CONFIG_DIR/stew_config_xdg.yaml"
    link_stew "$CONFIG_DIR/stew_config_home.yaml"
    ;;
  unlink)
    unlink_stew "$CONFIG_DIR/stew_config_xdg.yaml"
    unlink_stew "$CONFIG_DIR/stew_config_home.yaml"
    ;;
  deactivate-zsh)
    deactivate_zsh
    ;;
  reactivate-zsh)
    reactivate_zsh
    ;;
  *)
    echo "Usage: $0 {link|unlink|deactivate-zsh|reactivate-zsh}"
    exit 1
    ;;
esac

