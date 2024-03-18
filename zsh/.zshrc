# Alias
alias ls='ls --color=auto'

# Prompt
git_prompt() {
    # Check if the current directory is in a Git repository
    if git rev-parse --git-dir > /dev/null 2>&1; then
        # Get the current branch name
        git_branch=$(git branch 2>/dev/null | grep '^*' | colrm 1 2)
        # Get the status of the repository
        git_status=$(git status --porcelain 2>/dev/null)
        # Set the color based on the status
        if [[ -n "$git_status" ]]; then
            echo -e " %{%F{yellow}%}(${git_branch})"
        else
            echo -e " %{%F{green}%}(${git_branch})"
        fi
    fi
}

setopt PROMPT_SUBST
PROMPT='%{%F{cyan}%}%1~% $(git_prompt)%{%F{blue}%} %% %{%F{none}%}'
