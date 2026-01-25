{ config, pkgs, ... }:

{
  # Home Manager version (do not change)
  home.stateVersion = "24.05";

  # User information
  home.username = "kagenmi";
  home.homeDirectory = "/home/kagenmi";

  # Package installation
  home.packages = with pkgs; [
    # Universal version manager (supports Go, Node.js, Python, Rust, Terraform, etc.)
    mise

    # Python package installer
    uv

    # Trash CLI managers
    trash-cli
    trashy
  ];

  # Program configurations (coexist with existing dotfiles)
  programs.home-manager.enable = true;

  # direnv - automatic Nix development environment loading
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # zoxide - smarter cd command
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # Environment variables
  home.sessionVariables = {
    EDITOR = "vim";
  };
}
