# =======================================================
#
# Shell Aliases
#
# =======================================================

# ls Versions with exa{{{
# detailed option - always used
alias l='exa -FalhH --git --time-style long-iso -g --icons'
# show detailed with tree
alias ltr='l --tree --git-ignore --ignore-glob=".git|__pycache__"'
# deprecated, but  fallback
alias ll='l'
# sort by modification date
alias lt='l -s modified'

# TODO (Berti): l. only dotiles, ld only directories, ll - something usefull, lg maybe only git-wroktree, lig - git
# ignored?

#}}}

# clipboard
alias xcopy='xclip -selection clipboard'
alias xpaste='xclip -selection clipboard -o'
alias xpf='xpfile'
alias xcf='xcfile'
alias xcp='xcpipe'
alias xpp='xppipe'

# python{{{
alias py='ptipython --vi'
alias pyt='python3 -m pytest' # pytest for locally running in folder
alias pys='pyspark'
alias ipy='ipython'
alias pym='pyhon3 -m'
alias pyi='pyhon3 -i'
alias fla='flake8 --ignore=C0330,E501'
alias python='python3'
alias pip='pip3'
alias poetenv='poetry env info -p'
#}}}

# tmux
alias t="tmux"
alias tp="tmuxp"
alias tls="tmux ls"

# autocorrect typos
alias mc='echo "i hate midnight commander"'
alias dc="cd"

# shortcuts
alias dot="cd ~/dotfiles"
alias aa='addalias'
alias wh='which'
alias v='nvim'
alias play='cd /home/bertold/projects/playground'

# I am used to type vim, but want nvim
alias vim='nvim'


# git
alias g='git'
alias gs='git status'
alias gdo='git done'


#alias diff='colordiff'
alias ct='countdown'
alias vc="create_python_venv"
alias va="activate_python_venv"
alias vd="deactivate"

# Apt
alias apti='sudo apt install'
alias aptu='sudo apt update'
alias aptug='sudo apt upgrade'
alias aptung='aptu && aptug -y'

