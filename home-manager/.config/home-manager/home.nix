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
    pkgs.eza
    pkgs.fh
    pkgs.fzf
    pkgs.gawk
    pkgs.htop
    pkgs.imagemagick
    pkgs.lazygit
    pkgs.pfetch
    pkgs.qrencode
    pkgs.ripgrep
    pkgs.starship
    pkgs.tree-sitter
    pkgs.yazi
    pkgs.zellij
    pkgs.zoxide

    # Fonts
    pkgs.nerd-fonts.hack
    pkgs.nerd-fonts.blex-mono
    # Editor
    pkgs.neovim

    # Verification
    pkgs.souffle

    # Languages
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

  # ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  home.sessionVariables = {
    EDITOR = "nvim";
    HISTFILE = "$HOME/.zsh_history";
    HISTSIZE = 1000;
    SAVEHIST = 1000;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
