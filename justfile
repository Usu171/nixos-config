default:
    @just --list

default_host := `hostname`

# 本地 switch
[group('deploy')]
sw:
  nh os switch

# Deploy to remote host via ssh
[group('deploy')]
de flake host:
  nixos-rebuild --flake .#{{flake}} --target-host {{host}} switch

# nixos
[group('deploy')]
nixos:
  nixos-rebuild --flake .#nixos --target-host root@Nix switch

# unix
[group('deploy')]
unix:
  nixos-rebuild --flake .#unix --target-host root@OS switch

# build iso installation media
[group('iso')]
iso isoname='installer' variant='myinstaller':
  nh os build-image -H {{isoname}} --image-variant {{variant}}
  # nixos-rebuild build-image --flake .#{{isoname}} --image-variant {{variant}}
  # nix build .#nixosConfigurations.{{isoname}}.config.system.build.images.{{variant}}

# seed mihomo files into ISO, build, then clean up
[group('iso')]
iso-with-mihomo isoname='installer' variant='myinstaller' config_path=(home_dir() + "/.local/share/mihomo/config.yaml") state_path='/var/lib/private/mihomo':
  #!/usr/bin/env bash
  set -euo pipefail

  target_dir="hosts/installer/mihomo"
  cleanup() {
    git restore --staged -- "$target_dir" 2>/dev/null || true
    rm -rf -- "$target_dir"
  }
  trap cleanup EXIT

  rm -rf -- "$target_dir"
  install -d -m 0755 "$target_dir"
  cp -f -- "{{config_path}}" "$target_dir/config.yaml"
  sudo cp -a -- "{{state_path}}/." "$target_dir/"
  sudo chown -R -- "$(id -u):$(id -g)" "$target_dir"
  chmod -R u+rwX,go-rwx "$target_dir"

  git add -- "$target_dir"
  nh os build-image -H {{isoname}} --image-variant {{variant}}

# show iso installation media config
[group('nix')]
show-iso-config config:
  nix eval --json --impure --expr 'let flake = builtins.getFlake (toString ./.); cfg = flake.nixosConfigurations.installer; final = cfg.extendModules { modules = [ cfg.config.image.modules.myinstaller ]; }; in final.config.{{config}} ' | jq

# show unix configuration
[group('nix')]
show-unix-config config:
    nix eval --json .#nixosConfigurations.unix.config.{{config}} | jq

# 显示主机 nixpkgs flake source 路径
[group('nix')]
show-flake-source hostname='':
    nix eval --raw .#nixosConfigurations.{{ if hostname == "" { default_host } else { hostname } }}.config.nixpkgs.flake.source


# ref:
# https://github.com/ryan4yin/nix-config/blob/main/Justfile
# https://github.com/ryan4yin/nix-config/blob/main/utils.nu
# https://nixos-and-flakes.thiscute.world/zh/best-practices/simplify-nixos-related-commands#%E4%BD%BF%E7%94%A8-justfile-%E7%AE%80%E5%8C%96-nixos-%E7%9B%B8%E5%85%B3%E5%91%BD%E4%BB%A4

# Update all the flake inputs
[group('nix')]
up:
  nix flake update --commit-lock-file

# Update specific input
# Usage: just upp nixpkgs
[group('nix')]
upp input:
  nix flake update {{input}} --commit-lock-file

# List all generations of the system profile
[group('nix')]
history:
  nix profile history --profile /nix/var/nix/profiles/system

# Open a nix shell with the flake
[group('nix')]
repl:
  nix repl -f flake:nixpkgs

# remove all old generations
# on darwin, you may need to switch to root user to run this command
[group('nix')]
clean:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system

# Garbage collect all unused nix store entries
[group('nix')]
gcc:
  # garbage collect all unused nix store entries(system-wide)
  sudo nix-collect-garbage --delete-older-than 7d
  # garbage collect all unused nix store entries(for the user - home-manager)
  # https://github.com/NixOS/nix/issues/8508
  nix-collect-garbage --delete-older-than 7d

# Garbage collect using nh
[group('nix')]
gc:
  nh clean all -K 7d --no-gcroots --optimise

# Garbage collect using nh in dry-run mode
[group('nix')]
gcn:
  nh clean all -K 7d --no-gcroots --optimise --dry

# upgrade determinate nix
[macos]
[group('nix')]
nix-upgrade:
  sudo determinate-nixd upgrade

[group('nix')]
fmt:
  nix fmt

# Show all the auto gc roots in the nix store
[group('nix')]
gcroot:
  ls -al /nix/var/nix/gcroots/auto/

# Verify all the store entries
# Nix Store can contains corrupted entries if the nix store object has been modified unexpectedly.
# This command will verify all the store entries,
# and we need to fix the corrupted entries manually via `sudo nix store delete <store-path-1> <store-path-2> ...`
[group('nix')]
verify-store:
  nix store verify --all

# Repair Nix Store Objects
[group('nix')]
repair-store *paths:
  nix store repair {{paths}}

# Update all Nixpkgs inputs
[group('nix')]
up-nix:
  nix flake update --commit-lock-file nixpkgs-stable nixpkgs-master nixpkgs-darwin nixpkgs-patched

# override nixpkgs's commit hash
[group('nix')]
override-pkgs hash:
  nix flake update --commit-lock-file nixpkgs --override-input nixpkgs github:NixOS/nixpkgs/{{hash}}
