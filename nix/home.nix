{ config, pkgs, lib, ... }:

{
  # Home Manager version (do not change)
  home.stateVersion = "24.05";

  # Note: home.username and home.homeDirectory are set in flake.nix

  # Package installation
  home.packages = with pkgs; [
    # AWS CLI v2
    awscli2

    # Dev container CLI
    devcontainer

    # Simple, fast alternative to find
    fd

    # Command-line fuzzy finder
    fzf

    # GitHub CLI tool
    gh

    # Command-line JSON processor
    jq

    # Universal version manager (supports Go, Node.js, Python, Rust, Terraform, etc.)
    mise

    # Python GitLab API client library
    python3Packages.python-gitlab

    # Fast search tool (grep alternative)
    ripgrep

    # Terminal multiplexer
    tmux

    # Trash CLI manager
    trash-cli

    # Directory tree visualization
    tree

    # Tree-sitter CLI for parser generation (v0.26.3 from GitHub releases for nvim-treesitter compatibility)
    (pkgs.stdenv.mkDerivation rec {
      pname = "tree-sitter";
      version = "0.26.3";

      src = pkgs.fetchurl {
        url = "https://github.com/tree-sitter/tree-sitter/releases/download/v${version}/tree-sitter-linux-x64.gz";
        hash = "sha256-T2XI2boyo+NxmDAlabMwbwN/EtgxPj8ozfG4DJ8rOjo=";
      };

      nativeBuildInputs = with pkgs; [ gzip autoPatchelfHook ];
      buildInputs = with pkgs; [ stdenv.cc.cc.lib ];

      dontUnpack = false;
      unpackPhase = ''
        gunzip -c $src > tree-sitter
        chmod +x tree-sitter
      '';

      installPhase = ''
        mkdir -p $out/bin
        cp tree-sitter $out/bin/tree-sitter
      '';

      meta = with pkgs.lib; {
        description = "Tree-sitter CLI";
        homepage = "https://tree-sitter.github.io/";
        platforms = platforms.linux;
      };
    })

    # Python package installer
    uv

    # X11 clipboard utility for WSL clipboard integration
    xclip
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

  # starship - cross-shell prompt
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  # sheldon - fast zsh plugin manager
  programs.sheldon = {
    enable = true;
  };

  # neovim - hyperextensible Vim-based text editor
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Environment variables
  home.sessionVariables = {
    # EDITOR is set by programs.neovim.defaultEditor
    # Zsh configuration paths
    ZSH_CONFIG_HOME = "${config.xdg.configHome}/zsh";
    # Sheldon configuration
    SHELDON_CONFIG_DIR = "${config.xdg.configHome}/zsh/sheldon";
    SHELDON_DATA_DIR = "${config.xdg.dataHome}/sheldon";
    # Starship configuration location
    # Use mkForce to override Home Manager's default starship config path
    STARSHIP_CONFIG = lib.mkForce "${config.home.sessionVariables.ZSH_CONFIG_HOME}/starship/config.toml";
  };
}
