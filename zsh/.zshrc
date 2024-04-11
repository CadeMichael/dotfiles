# Completion
autoload -Uz compinit && compinit
# case insensitive path-completion 
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# Packages
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# [Homebrew]
# Curl
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/curl/lib"
export CPPFLAGS="-I/opt/homebrew/opt/curl/include"
# Libtool
export PATH="/opt/homebrew/opt/libtool/libexec/gnubin:$PATH"

# [npm global]
# add to ~/.npmrc -> prefix="$HOME/.npm-global"
export PATH="$PATH:$HOME/.npm-global/bin"
# for local npm installs
export PATH=$PATH:./node_modules/.bin
# [nim]
export PATH="$PATH:$HOME/.nimble/bin"

# Alias
alias ls='ls --color=auto'
alias vi=nvim

# Prompt
# git_prompt() {
    # # Check if the current directory is in a Git repository
    # if git rev-parse --git-dir > /dev/null 2>&1; then
        # # Get the current branch name
        # git_branch=$(git branch 2>/dev/null | grep '^*' | colrm 1 2)
        # # Get the status of the repository
        # git_status=$(git status --porcelain 2>/dev/null)
        # # Set the color based on the status
        # if [[ -n "$git_status" ]]; then
            # echo -e " %{%F{yellow}%}(${git_branch})"
        # else
            # echo -e " %{%F{green}%}(${git_branch})"
        # fi
    # fi
# }

# setopt PROMPT_SUBST
# PROMPT='%{%F{cyan}%}%1~% $(git_prompt)%{%F{blue}%} %% %{%F{none}%}'

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE='/opt/homebrew/opt/micromamba/bin/micromamba';
export MAMBA_ROOT_PREFIX='/Users/cade/micromamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

# function for activating mamba envs
# mcm => micromamba
function mcm() {
  MAMBA_ENVS="$HOME/micromamba/envs/"

  if [[ "$1" == "-d" ]]; then
    micromamba deactivate
  else
    # Use fzf to select a directory
    selected_env=$(ls "$MAMBA_ENVS" | fzf)
    # Check if a directory was selected
    if [ -n "$selected_env" ]; then
        micromamba activate "$selected_env"
    else
        echo "No env selected."
    fi
  fi
}

eval "$(starship init zsh)"
