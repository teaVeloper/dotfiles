# =================================================================
#  ______            _                                      _     |
# |  ____|          (_)                                    | |    |
# | |__   _ ____   ___ _ __ ___  _ __  _ __ ___   ___ _ __ | |_   |
# |  __| | '_ \ \ / / | '__/ _ \| '_ \| '_ ` _ \ / _ \ '_ \| __|  |
# | |____| | | \ V /| | | | (_) | | | | | | | | |  __/ | | | |_   |
# |______|_| |_|\_/ |_|_|  \___/|_| |_|_| |_| |_|\___|_| |_|\__|  |
#                                                                 |
# =================================================================
#
#
# This file is symlinked or otherwise available at
#   $HOME/.zshenv
# probably the same file will be symlinked for other init processes
# to setup the environment!
# It will setup $ZDOTDIR and thus zsh know where to find other configs
# Most settings make even for bash sense - identical, so it can
# be sourced within .bash_profile or .bashrc


# {{{ general and personal settings
export DOTFILES="$HOME/dotfiles"
export WORKSPACE="$HOME/workspace"

export VIMRC="$DOTFILES/vim/init.vim"
export ZSHRC="$DOTFILES/zsh/zshrc"
export MYALIAS="$DOTFILES/shell/alias.sh"
export MYFUNCTIONS="$DOTFILES/shell/functions.sh"
export MYENV="$DOTFILES/zsh/zshenv.zsh"
export TMUXCONF="$DOTFILES/tmux/tmux.conf"
export GITCONF="$DOTFILES/git/gitconfig"
export VCSIGNORE="$DOTFILES/git/globalignore"
export EDITORCONFIG="$DOTFILES/.editorconfig"

export EDITOR='nvim'
export VISUAL='nvim'
# export PAGER='batcat'
export MANPAGER='nvim +Man!'

# }}}

# {{{ XDG base settings
# Folder structure follows XDG - Standard
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html

export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache
export XDG_STATE_HOME=$HOME/.local/state
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
# TODO (Berti): XDG_DATA_DIRS
#
# More details on supported, partly or not supported tools
# https://wiki.archlinux.org/title/XDG_Base_Directory

# }}}

# {{{ Python Stack
# Python
# export PYLINTHOME="$XDG_CACHE_HOME"/pylint.d
# export PYTHONSTARTUP="$XDG_CONFIG_HOME"/python/pythonrc
export PYTHON_EGG_CACHE="$XDG_CACHE_HOME"/python-eggs
export PYTHON_VENVS="$XDG_CACHE_HOME"/python-venvs
# Conda
export CONDARC="$XDG_CONFIG_HOME/conda/condarc"
# Mypy
export MYPY_CACHE_DIR="$XDG_CACHE_HOME"/mypy
# venvs
export WORKON_HOME="$XDG_DATA_HOME/virtualenvs"
# }}}

# {{{ Application Settings
# some or most are not dependent on existence or installation of the applications
# some are even helpfull beforehand

# Docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker

# GPG
export GNUPGHOME="$XDG_DATA_HOME"/gnupg

# GO
export GOPATH="$XDG_DATA_HOME"/go
export GOBIN="$GOPATH"/bin

# Pass & Gopass
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass


# Readline
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc

# Ripgrep
export RIPGREP_CONFIG_PATH=$XDG_CONFIG_HOME/ripgrep/config

# Rust / Cargo
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

# Stack
export STACK_ROOT="$XDG_DATA_HOME"/stack
# Cabal
export CABAL_CONFIG="$XDG_CONFIG_HOME"/cabal/config
export CABAL_DIR="$XDG_CACHE_HOME"/cabal

# KDE
export KDEHOME="$XDG_CONFIG_HOME"/kde

# K9S
export K9SCONFIG="$XDG_CONFIG_HOME"/k9s

# Ack
export ACKRC="$XDG_CONFIG_HOME/ack/ackrc"

# AWS CLI
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config

# Node / npm
# https://github.com/npm/npm/issues/6675#issuecomment-251049832
export NODE_REPL_HISTORY="$XDG_CACHE_HOME"/node_repl_history
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME"/npm
export NPM_CONFIG_TMP="$XDG_RUNTIME_DIR"/npm
export NVM_DIR="$HOME/.config/nvm"


# Tmux stack
# export TMUXP_CONFIGDIR="$XDG_CONFIG_HOME/tmuxp"
export TMUX_PLUGIN_MANAGER_PATH="$XDG_CONFIG_HOME"/tmux/plugins/
export TMUXP_CONFIGDIR="$XDG_CONFIG_HOME"/tmux/tmuxp

# TMUXP
export DISABLE_AUTO_TITLE='true'
# }}}

# {{{ zsh + tools
export ZDOTDIR="$XDG_CONFIG_HOME"/zsh
export _Z_DATA="$XDG_CACHE_HOME"/.z
export HISTFILE="$XDG_STATE_HOME"/zsh/history
export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE

# }}}


# {{{ set up PATH
export PATH="/sbin:$PATH"
export PATH="/usr/sbin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
# if [ -d "$HOME/anaconda3" ]; then
#   export PATH="$HOME/anaconda3/bin:$PATH"
# fi
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="/usr/local:$PATH"
export PATH="$CARGO_HOME/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
# export PATH="$PATH:$HOME/Applications"
# }}}

# {{{ settings dependend on existence of installs
# this section may also move somewhere else.. as this should probably be a static only settings file
# only defining environment variables reusing others and not much more
if [ -d "/opt/spark" ]; then
  export SPARK_HOME="/opt/spark"
  export PATH="$PATH:$SPARK_HOME/bin"
  export PYTHONPATH=$(ZIPS=("$SPARK_HOME"/python/lib/*.zip); IFS=:; echo "${ZIPS[*]}"):$PYTHONPATH
fi

# }}}
