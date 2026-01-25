# Nix & Home Manager Configuration

Reproducible development environment configuration using Nix package manager and Home Manager.

## File Structure

```
dotfiles/
├── flake.nix          # Nix Flakes entry point
└── nix/
    ├── home.nix       # Home Manager configuration
    ├── config/        # Nix configuration directory
    │   └── nix.conf
    └── README.md
```

## Setup

### Install Nix

```bash
sh <(curl -L https://nixos.org/nix/install) --no-daemon
. ~/.nix-profile/etc/profile.d/nix.sh
echo '. ~/.nix-profile/etc/profile.d/nix.sh' >> ~/.zshrc
```

### Create Symlink

```bash
ln -sf ~/path/to/dotfiles/nix/config ~/.config/nix
```

### Apply Configuration

```bash
cd ~/path/to/dotfiles
nix flake update
nix run home-manager/master -- switch --flake .#default
exec $SHELL
```

## Installed Packages

- **mise** - Universal version manager
- **uv** - Python package installer
- **trash-cli** - Trash manager
- **trashy** - Rust-based trash manager

Shell integrations:
- **direnv** - Environment variable loader
- **zoxide** - Fast directory jumper

## Usage

### Add Packages

Edit `nix/home.nix`:

```nix
home.packages = with pkgs; [
  mise
  uv
  ripgrep  # Add new package
];
```

Apply changes:

```bash
cd ~/path/to/dotfiles
home-manager switch --flake .#default
```

### Remove Packages

1. Remove from `nix/home.nix`
2. Apply configuration
3. Run garbage collection:

```bash
nix-collect-garbage -d
```

## Common Commands

```bash
# Apply configuration
home-manager switch --flake .#default

# Search packages
nix search nixpkgs <package-name>

# List installed packages
nix profile list

# Update dependencies
nix flake update

# Clean up old generations
nix-collect-garbage -d
```

## Sync to Other Devices

```bash
# Install Nix
sh <(curl -L https://nixos.org/nix/install) --no-daemon
. ~/.nix-profile/etc/profile.d/nix.sh
echo '. ~/.nix-profile/etc/profile.d/nix.sh' >> ~/.zshrc

# Pull dotfiles
cd ~/path/to/dotfiles
git pull

# Create symlink
ln -sf ~/path/to/dotfiles/nix/config ~/.config/nix

# Apply configuration
nix flake update
nix run home-manager/master -- switch --flake .#default
exec $SHELL
```

## References

- [Nix Manual](https://nixos.org/manual/nix/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [NixOS Wiki](https://nixos.wiki/)
