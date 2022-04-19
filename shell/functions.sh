# =======================================================
#
# Shell Functions
#
# these need to be sourced to work, or be convenient
# some might be zsh specific, i try to be as compatible
# as I can.
#
# =======================================================

# Clipboard functions{{{

xcfile()
{ # TODO (Berti): review
  cat $1 | xclip -selection clipboard
}

xpfile()
{
  filename=$1
  xclip -o > "$filename"
}


#}}}


# CSV File Handling functions{{{
csvh()
{
  if [ -z "$2" ]
  then
    head "$1" | csvlook
  else
    head "$1" -n "$2" | csvlook
  fi
}

csvt()
{
  if [ -z "$2" ]
  then
    (head "$1" -n 1 && tail "$1" ) | csvlook
  else
    (head "$1" -n 1 && tail "$1" -n "$2") | csvlook
  fi
}
#}}}

addalias()
{
  alias=$1
  function=($@)
  echo "alias ${alias}='${function[@]:1}'" >> ~/dotfiles/shell/alias.sh
}


unproxy()
{
  if [ $# -eq 0 ]; then
    unset {http,https}_proxy
    unset {HTTP,HTTPS}_PROXY
  else
    printf -v joined '%s,' "$@"
    echo "export no_proxy=\$no_proxy,${joined%,}" >> ~/dotfiles/shell/no_proxy
  fi
}

create_python_venv () {
  python3 -m venv "${PYTHON_VENVS}/$(basename $(pwd))"
}

activate_python_venv () {
  source "$(poetenv)/bin/activate"
  # source "$PYTHON_VENVS}/$(basename $(pwd))/bin/activate"
}
# TODO (Berti): function group python:venv:*
# create - options for custom folder, otherwise $PYTHON_VENVS
# activate - option to use poetry venv, if exists, custom or default
# deactivate (only alias!)
# delete - option to use poetry, custom or default

python::venv::name () {
  dir_=$1
  git_base_path=$(_git_base_path "$dir_")
  hash_=$(echo "$git_base_path" | md5sum | head -c 10)
  base_path=$(basename "$git_base_path")
  venv_name="$base_path-$hash_"
  venv_path=$PYTHON_VENVS/$venv_name
  print "$venv_path"
}

python::venv::create () {
  venv_path=$(python::venv::name "$PWD")
  python3 -m venv "$venv_path"
}

python::venv::delete () {
  venv_path=$(python::venv::name "$PWD")
  rm -rf "$venv_path"
}

python::venv::activate () {
  venv_path=$(python::venv::name "$PWD")
  source "$venv_path/bin/activate"
}

python::venv::pactivate () {
  source "$(poetenv)/bin/activate"
}


dbfsl () {
  dbfs ls dbfs:$1
}


vpn () {
  opt=$1
  case $opt
  in
    status)
      systemctl status vpn
      ;;
    *)
      sudo systemctl "$opt" vpn
      ;;
  esac
}

_is_git_repo () {
  git rev-parse --is-inside-work-tree
}

_git_base_path() {
  base_path=$(git rev-parse --show-toplevel)
  print "$base_path"
}

vplug () {
  # Function to handle vimplug from CLI
  # just a way to more conveniently fire
  # up what I need, in case I want
  opt=$1
  plugin=$2
  case $opt
    in
      install)
        nvim -c "PlugInstall" -c "qa"
        ;;
      clean)
        nvim -c "PlugClean" -c "qa"
        ;;
      update)
        nvim -c "PlugUpdate" -c "qa"
        ;;
      edit)
        nvim "$HOME/dotfiles/vim/vimplugins.vim"
        ;;
      add)
        ins="Plug '$plugin'"
        sed -i "/call plug#end()/i $ins\n" "$HOME/dotfiles/vim/vimplugins.vim"
  esac
}

lns () {
  file=$1

  if [ -z "$2" ]; then
    link="$HOME/.local/bin"
  else
    link=$2
  fi
  ln -s "$PWD/$file" "$link"
}

linstall() {
  # Create Softlin in local bin
  # force, create backup and use custom suffix .lbk
  # TODO (Berti): add a folder and database for linstalled binaries
  binary=$1
  ln -sfb -S .lbk "$binary" "$HOME/.local/bin"
}

binstall() {
  # TODO (Berti):add folder and database for binstalled binaries
  binary=$1
  install $binary "$HOME/.local/bin"
}


cheat() {
  command_=$1
  curl "cheat.sh/${command_}"
}

weather() {
  options_=$1
  curl "wttr.in/${options_}"
}
