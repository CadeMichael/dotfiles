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
# libpq
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libpq/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libpq/lib/pkgconfig"

# [go]
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin
# [npm global]
# add to ~/.npmrc -> prefix="$HOME/.npm-global"
export PATH="$PATH:$HOME/.npm-global/bin"
# for local npm installs
export PATH=$PATH:./node_modules/.bin
# [bun]
# completions
[ -s "/Users/cade/.bun/_bun" ] && source "/Users/cade/.bun/_bun"
# paths
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# [opam]
[[ ! -r /Users/cade/.opam/opam-init/init.zsh ]] || source /Users/cade/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# Alias
alias l='ls --color=auto -F'
alias v=nvim
alias oil="nvim ./"
alias pss="ps aux | rg -i "
# [git]
alias lg=lazygit
alias ga='git add .'
alias gc='git commit'
alias gd='git diff'
alias gs='git status'
# [zellij]
alias za='zellij a'
alias zs='zellij -s'
alias zd='zellij d'
alias zda='zellij da'
# [uv]
alias uve='source env/bin/activate'
alias uvi='uv pip install'
alias uvu='uv pip uninstall'
# [cargo]
alias cr='cargo run'
alias cb='cargo build'
alias ct='cargo test -- --nocapture'
alias ca='cargo add'
# [firefox]
alias ff='open -a /Applications/Firefox.app'

# [zoxide]
eval "$(zoxide init zsh --cmd cd)"
# [starship]
eval "$(starship init zsh)"

