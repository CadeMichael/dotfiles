#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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
light_green="\[\033[0;32m\]"
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
          git_change="$yellow"
        else
          git_change="$light_green"
        fi
        # Combine the branch name and color
        echo -e " $git_change($git_branch)"
    fi
}

# Set the prompt to include the Git status
export PS1="$green\W$(git_prompt) $purple\$ $white"
