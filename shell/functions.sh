function _ls {
  command ls -F -h --color=always -v --author --time-style=long-iso -C "$@" | less -R -X -F
}
# Clipboard functions
function xcfile
{
    cat $1 | xclip -selection clipboard
}
function xpfile
{
        local filename=$1
        xclip -o > $filename
}

function xcpipe
{

    $1 | tee /dev/tty | xclip -selection clipboard
}

function xppipe
{
        eval $(xclip -selection clipboard -o)
}


# CSV File Handling functions
function csvh
{
  if [ -z $2 ]
  then
          head $1 | csvlook
  else  
        head $1 -n $2 | csvlook
        fi
}
function csvt
{
  if [ -z $2 ]
  then
          (head $1 -n 1 && tail $1 ) | csvlook
  else  
        (head $1 -n 1 && tail $1 -n $2) | csvlook
        fi
}

function addalias
{
        local alias=$1
        local function=($@)
        echo "alias ${alias}='${function[@]:1}'" >> ~/dotfiles/shell/aliases
}

function proxy
{
    export {http,https}_proxy=proxy
}

function unproxy
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
    source "${PYTHON_VENVS}/$(basename $(pwd))/bin/activate"
}

dbfsl () {
        dbfs ls dbfs:$1
}


vpn () {
        local opt=$1
        case $opt
        in
                status)
                        systemctl status vpn
                        ;;
                *)
                        sudo systemctl $opt vpn
                        ;;
        esac
}

_is_git_repo () {
    git rev-parse --is-inside-work-tree
}

_git_base_path() {
    git rev-parse --show-toplevel
}
