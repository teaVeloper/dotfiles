#!/bin/bash

LINSTALL_DATA_DIR="$XDG_DATA_HOME/linstall"
LINSTALL_LIST="$LINSTALL_DATA_DIR/installed_binaries.list"
BIN_DIR="$HOME/.local/bin"


mkdir -p "$LINSTALL_DATA_DIR"

# Function to link binaries
linstall() {
  local src_path="$1"
  local target_name="$2"

  if [ -z "$src_path" ]; then
    echo "Usage: linstall <source_path> [target_name]"
    return 1
  fi

  local src_file
  for src_file in "$src_path"/*; do
    local binary="${PWD}/$src_file"
    local name="${target_name:-$(basename "$src_file")}"
    local target="$BIN_DIR/$name"

    ln -sfb -S .lbk "$binary" "$target"

    # Record the installed binary
    echo "$(sha256sum "$binary" | awk '{print $1}') $binary $target" >> "$LINSTALL_LIST"
  done
}

# Function to unlink binaries
unlinstall() {
  local target_name="$1"

  if [ -z "$target_name" ]; then
    echo "Usage: unlinstall <target_name>"
    return 1
  fi

  local target="$BIN_DIR/$target_name"

  # Remove the symlink
  if [ -L "$target" ]; then
    rm "$target"
    echo "Removed $target"
  else
    echo "$target is not a symlink"
    return 1
  fi

  # Remove the record from the installed binaries list
  sed -i "\| $target\$|d" "$LINSTALL_LIST"
}

# Function to update installed binaries
update_linstall() {
  while read -r line; do
    local hash src target
    read -r hash src target <<< "$line"

    # Check if the source file has been modified
    if [ "$(sha256sum "$src" | awk '{print $1}')" != "$hash" ]; then
      ln -sfb -S .lbk "$src" "$target"
      echo "Updated $target"
    fi
  done < "$LINSTALL_LIST"
}
