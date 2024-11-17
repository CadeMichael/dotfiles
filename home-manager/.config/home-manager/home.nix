{ config, pkgs, ... }:

# when you need an older package
# let
# pkgStable = import <stable> { };
# in
{
  # User information
  home.username = "cade";
  home.homeDirectory = "/Users/cade";

  # Compatible Home Manager release
  home.stateVersion = "24.05";

  # Allow home manager to configure fonts
  fonts.fontconfig.enable = true;
  # Installed packages
  home.packages = [
    # Terminal
    pkgs.bat
    pkgs.coreutils
    pkgs.fzf
    pkgs.gawk
    pkgs.htop
    pkgs.imagemagick
    pkgs.lazygit
    pkgs.pfetch
    pkgs.qrencode
    pkgs.ripgrep
    pkgs.starship
    pkgs.tmux
    pkgs.tree
    pkgs.tree-sitter
    pkgs.zoxide

    # Fonts
    (pkgs.nerdfonts.override {
      fonts = [
        "IBMPlexMono"
        "Hack"
      ];
    })
    # Editor
    pkgs.neovim

    # Verification
    pkgs.elan
    pkgs.souffle

    # Languages
    # -> C/C++
    # pkgs.gcc
    # pkgs.libgcc
    # -> flix
    pkgs.flix
    # -> lua
    pkgs.luajit
    pkgs.lua-language-server
    # -> go
    pkgs.go
    pkgs.gopls
    # -> haskell
    pkgs.ghc
    pkgs.cabal-install
    pkgs.stack
    # -> nix
    pkgs.nixd
    pkgs.nixfmt-rfc-style
    # -> python
    pkgs.uv
  ];

  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  home.sessionVariables = {
    EDITOR = "nvim";
    HISTFILE = "$HOME/.zsh_history";
    HISTSIZE = 1000;
    SAVEHIST = 1000;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
