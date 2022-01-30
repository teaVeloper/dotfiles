# Setup fzf
# ---------
if [[ ! "$PATH" == */home/berti/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/berti/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/berti/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/berti/.fzf/shell/key-bindings.zsh"
