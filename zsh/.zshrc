# Completion
autoload -Uz compinit && compinit
# case insensitive path-completion 
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# [home manager]
. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

# Packages
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# [Homebrew]
# bison
export LDFLAGS="-L/opt/homebrew/opt/bison/lib"
export PATH="/opt/homebrew/opt/bison/bin:$PATH"

# curl
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/curl/lib"
export CPPFLAGS="-I/opt/homebrew/opt/curl/include"

# libtool
export PATH="/opt/homebrew/opt/libtool/libexec/gnubin:$PATH"

# libpq
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libpq/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libpq/lib/pkgconfig"

# llvm
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"

# [go]
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin

# [tex]
export PATH="/Library/TeX/texbin:$PATH"

# [npm global]
# add to ~/.npmrc -> prefix="$HOME/.npm-global"
export PATH="$PATH:$HOME/.npm-global/bin"
# for local npm installs
export PATH=$PATH:./node_modules/.bin

# [zig]
export PATH="$PATH:$HOME/Downloads/zig-macos-aarch64-0.14.0-dev.2627+6a21d18ad"
export PATH="$PATH:$HOME/Downloads/zls/zig-out/bin"

# [opam]
[[ ! -r /Users/cade/.opam/opam-init/init.zsh ]] || source /Users/cade/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# Alias

# [eza]
alias l='eza'
alias ls='eza --icons'
function lt() {
  eza -T --level=$1
}
# [nvim]
alias v=nvim
alias oil="nvim ./"

# [system]
alias pss="ps aux | rg -i "
alias utar="tar -xvzf"

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

# [home-manager]
alias hms='home-manager switch'
alias hmd='home-manager switch && nix-collect-garbage -d'

# [firefox]
alias ff='open -a /Applications/Firefox.app'
# [preview]
alias preview='open -a Preview'

# [zoxide]
eval "$(zoxide init zsh --cmd cd)"

# [starship]
eval "$(starship init zsh)"

# [fish]
exec fish
