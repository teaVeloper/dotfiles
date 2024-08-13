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


python::venv::pdelete () {
  if [ -z "$1" ]; then
    python_version=python3.8
  else
    python_version=$1
  fi
  poetry env remove "${python_version}"

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
        nvim -c "PlugUpdate"
        ;;
      updateq)
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
  binary="${PWD}/$1"
  if [ -z "$2" ]; then
    name=$1
  else
    name=$2
  fi
  ln -sfb -S .lbk "$binary" "$HOME/.local/bin/${name}"
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

work() {
  workdir="${WORKSPACE}/$1"
  if [ -d  "$workdir" ]; then
    cd "$workdir"
  else
    echo "creating $workdir"
    mkdir -p "$workdir"
    cd "$workdir"
  fi
}

pyf() {
  if [ $# -eq 0 ]; then
    folders="."
  else
    folders=($@)
  fi

  fd -E "__init__.py" ".py$" $folders
}


# vpy() {
#   if [ $# -eq 0 ]; then
#     folder="."
#   else
#     folder=($@)
#   fi
#
#   "$EDITOR" $(pyf $folder) # no "" around array, to expand appropriately
# }

# Function to find files with specified extensions, optionally excluding __init__.py
find_files() {
  local exclude_init=true
  local extensions=("py")
  local folders=(".")

  while [[ $# -gt 0 ]]; do
    case $1 in
      --include-init)
        exclude_init=false
        shift
        ;;
      -t|--type)
        shift
        extensions=(${1//,/ })
        shift
        ;;
      *)
        folders+=("$1")
        shift
        ;;
    esac
  done

  local ext_pattern=$(printf "|%s" "${extensions[@]}")
  ext_pattern=${ext_pattern:1}  # Remove leading |

  if $exclude_init; then
    fd -E "__init__.py" -e $ext_pattern ${folders[@]}
  else
    fd -e $ext_pattern ${folders[@]}
  fi
}

# Function to open files with the specified editor
vpy() {
  local editor=${EDITOR:-nvim}
  local folders=(".")

  if [[ $# -gt 0 ]]; then
    folders=("$@")
  fi

  "$editor" $(find_files "${folders[@]}")
}

# Generalized function for opening files with specified types
ev() {
  local editor=${EDITOR:-nvim}
  local extensions=("py")
  local include_init=false
  local folders=(".")

  while [[ $# -gt 0 ]]; do
    case $1 in
      --include-init)
        include_init=true
        shift
        ;;
      -t|--type)
        shift
        extensions=(${1//,/ })
        shift
        ;;
      *)
        folders+=("$1")
        shift
        ;;
    esac
  done

  if $include_init; then
    "$editor" $(find_files --include-init -t "${extensions[@]}" "${folders[@]}")
  else
    "$editor" $(find_files -t "${extensions[@]}" "${folders[@]}")
  fi
}

# make v a function not an alias
# v filenames -> nvim filenames
# v -e extension foldername
# v foldername -> all files from folder - recurse?
# v exclude, include, etc. sensible defaults?
# basically wrap fd or rg --files or such with nice
# options and defaults as input for the nvim/$EDITOR command

extract() {
    case $1 in
        *.tar.bz2)  tar xjf $1      ;;
        *.tar.gz)   tar xzf $1      ;;
        *.bz2)      bunzip2 $1      ;;
        *.gz)       gunzip $1       ;;
        *.tar)      tar xf $1       ;;
        *.tbz2)     tar xjf $1      ;;
        *.tgz)      tar xzf $1      ;;
        *.zip)      unzip $1        ;;
        *.7z)       7z x $1         ;; # require p7zip
        *.rar)      7z x $1         ;; # require p7zip
        *.iso)      7z x $1         ;; # require p7zip
        *.Z)        uncompress $1   ;;
        *)          echo "'$1' cannot be extracted" ;;
    esac
}

screenshot () {
    local DIR="$SCREENSHOT"
    local DATE="$(date +%Y%m%d-%H%M%S)"
    local NAME="${DIR}/screenshot-${DATE}.png"

    # Check if the dir to store the screenshots exists, else create it:
    if [ ! -d "${DIR}" ]; then mkdir -p "${DIR}"; fi

    # Screenshot a selected window
    if [ "$1" = "win" ]; then import -format png -quality 100 "${NAME}"; fi

    # Screenshot the entire screen
    if [ "$1" = "scr" ]; then import -format png -quality 100 -window root "${NAME}"; fi

    # Screenshot a selected area
    if [ "$1" = "area" ]; then import -format png -quality 100 "${NAME}"; fi

    if [[ $1 =~ "^[0-9].*x[0-9].*$" ]]; then import -format png -quality 100 -resize $1 "${NAME}"; fi

    if [[ $1 =~ "^[0-9]+$" ]]; then import -format png -quality 100 -resize $1 "${NAME}" ; fi

    if [[ $# = 0 ]]; then
        # Display a warning if no area defined
        echo "No screenshot area has been specified. Please choose between: win, scr, area. Screenshot not taken."
    fi
}

# cdg() {
#     git_base_path=$(git rev-parse --show-toplevel 2>/dev/null)
#     if [ $? -ne 0 ]; then
#         echo "Not a git repository"
#         return 1
#     fi
#     cd "$git_base_path"
# }

cdg() {
    if [ $# -eq 0 ]; then
        git_base_path=$(git rev-parse --show-toplevel 2>/dev/null)
        if [ $? -ne 0 ]; then
            echo "Not a git repository"
            return 1
        fi
        cd "$git_base_path"
    else
        branch_name=$1
        git_base_path=$(git rev-parse --show-toplevel 2>/dev/null)
        if [ $? -ne 0 ]; then
            echo "Not a git repository"
            return 1
        fi
        worktree_path="${git_base_path}/worktrees/${branch_name}"

        if [ -d "$worktree_path" ]; then
            cd "$worktree_path"
        else
            echo "Worktree for branch '$branch_name' does not exist. Create it? (y/n)"
            read answer
            if [ "$answer" != "${answer#[Yy]}" ]; then
                mkdir -p "$worktree_path"
                git worktree add "$worktree_path" "$branch_name"
                cd "$worktree_path"
            else
                echo "Operation canceled."
                return 1
            fi
        fi
    fi
}

# Autocompletion for branch names
_cdg_complete() {
    local cur branches
    cur=${COMP_WORDS[COMP_CWORD]}
    branches=$(git branch --all | grep -v '/HEAD' | grep -oE '[^ ]+$')
    COMPREPLY=( $(compgen -W "$branches" -- "$cur") )
}

# complete -F _cdg_complete cdg

# Fzf integration for branch selection
cdg_fzf() {
    git_base_path=$(git rev-parse --show-toplevel 2>/dev/null)
    if [ $? -ne 0 ]; then
        echo "Not a git repository"
        return 1
    fi
    branch_name=$(git branch --all | grep -v '/HEAD' | grep -oE '[^ ]+$' | fzf)
    if [ -z "$branch_name" ]; then
        echo "No branch selected"
        return 1
    fi
    cdg "$branch_name"
}



knew () {
  # restart kde after crashing - happens quite regular
        kquitapp5 plasmashell
        kstart5 plasmashell
}



# from omz {{{
# mkcd is equivalent to takedir
function mkcd takedir() {
  mkdir -p $@ && cd ${@:$#}
}

function takeurl() {
  local data thedir
  data="$(mktemp)"
  curl -L "$1" > "$data"
  tar xf "$data"
  thedir="$(tar tf "$data" | head -n 1)"
  rm "$data"
  cd "$thedir"
}

function takegit() {
  git clone "$1"
  cd "$(basename ${1%%.git})"
}

function take() {
  if [[ $1 =~ ^(https?|ftp).*\.tar\.(gz|bz2|xz)$ ]]; then
    takeurl "$1"
  elif [[ $1 =~ ^([A-Za-z0-9]\+@|https?|git|ssh|ftps?|rsync).*\.git/?$ ]]; then
    takegit "$1"
  else
    takedir "$@"
  fi
}

# create __init__.py in all folders provided it not exist
function initpy() {
  for f in $@
    do
      touch $f/__init__.py
    done
}


# }}}
