#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# tab completion
bind -s 'set completion-ignore-case on'

# fzf
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vi=nvim
alias zzz='sudo systemctl suspend'
alias pj=$HOME/CS/scripting/pj-script.sh


# [go]
export PATH=$PATH:/home/cade/go/bin

# [scala]
export PATH="$PATH:/home/cade/.local/share/coursier/bin"

# [npm global]
# add to ~/.npmrc -> prefix=/home/cade/.npm-global
export PATH="$PATH:/home/cade/.npm-global/bin"

# for local npm installs
export PATH=$PATH:./node_modules/.bin

# [foundry]
export PATH="$PATH:/home/cade/.foundry/bin"

# Prompt Stuff
green="\[\033[0;36m\]"
purple="\[\033[0;35m\]"
white="\[\033[0m\]"
yellow="\[\033[0;33m\]"
# get dir git status
git_prompt() {
    # Check if the current directory is in a Git repository
    if git rev-parse --git-dir > /dev/null 2>&1; then
        # Get the current branch name
        git_branch=$(git branch 2>/dev/null | grep '^*' | colrm 1 2)
        # Get the status of the repository
        git_status=$(git status --porcelain 2>/dev/null)
        # Set the color based on the status
        if [[ -n "$git_status" ]]; then
            git_change="ˣ"
        else
            git_change=""
        fi
        # Combine the branch name and color
        echo -e " (${git_branch}${git_change})"
    fi
}

# Set the prompt to include the Git status
export PS1="$green\W$yellow\$(git_prompt) $purple\$ $white"

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE='/usr/bin/micromamba';
export MAMBA_ROOT_PREFIX='/home/cade/micromamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<
