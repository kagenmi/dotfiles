{ config, pkgs, ... }:

{
  # Home Manager version (do not change)
  home.stateVersion = "24.05";

  # Note: home.username and home.homeDirectory are set in flake.nix

  # Package installation
  home.packages = with pkgs; [
    # Universal version manager (supports Go, Node.js, Python, Rust, Terraform, etc.)
    mise

    # Python package installer
    uv

    # Trash CLI manager
    trash-cli

    # Python GitLab API client library
    python3Packages.python-gitlab
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
