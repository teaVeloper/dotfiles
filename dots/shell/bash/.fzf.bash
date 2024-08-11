# Setup fzf
# ---------
if [[ ! "$PATH" == */home/uzkc7y5/dev/tools/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/uzkc7y5/dev/tools/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/uzkc7y5/dev/tools/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/uzkc7y5/dev/tools/.fzf/shell/key-bindings.bash"
