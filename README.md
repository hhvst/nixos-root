# Nixos configurations

## References
- https://github.com/Misterio77/nix-config
- https://haseebmajid.dev/posts/2024-07-30-how-i-setup-btrfs-and-luks-on-nixos-using-disko
- https://nix-community.github.io/nixos-anywhere/quickstart

## Installation
```
nix run github:nix-community/nixos-anywhere -- --flake .#ulthc \
  --generate-hardware-config nixos-generate-config \
  ./hosts/ulthc/hardware-configuration.nix --target-host <user>@<hostname>
```
