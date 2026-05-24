default:
    @just --list

default_host := `hostname`

# 本地 switch
[group('deploy')]
sw:
  nh os switch

# 部署到远程主机
[group('deploy')]
de flake host:
  nh os switch -H {{flake}} --target-host {{host}}

# 部署到nixos
[group('deploy')]
nixos:
  nh os switch -H nixos --target-host Nix

# 部署到unix
[group('deploy')]
unix:
  nh os switch -H unix --target-host OS

# 部署到远程主机 via nixos-rebuild
[group('deploy')]
de-nr flake host:
  nixos-rebuild --flake .#{{flake}} --target-host {{host}} switch

# 部署到nixos via nixos-rebuild
[group('deploy')]
nixos-nr:
  nixos-rebuild --flake .#nixos --target-host root@Nix switch

# 部署到unix via nixos-rebuild
[group('deploy')]
unix-nr:
  nixos-rebuild --flake .#unix --target-host root@OS switch

# 构建iso安装镜像
[group('iso')]
iso isoname='installer' variant='myinstaller':
  nh os build-image -H {{isoname}} --image-variant {{variant}}
  # nixos-rebuild build-image --flake .#{{isoname}} --image-variant {{variant}}
  # nom build .#nixosConfigurations.{{isoname}}.config.system.build.images.{{variant}}

# 构建iso安装镜像复制mihomo配置
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

# 构建wsl
[group('build')]
build-wsl host='build-wsl':
  sudo nix run .#nixosConfigurations.{{host}}.config.system.build.tarballBuilder
  # nom build .#nixosConfigurations.{{host}}.config.system.build.tarballBuilder && sudo ./result/bin/nixos-wsl-tarball-builder

# 显示主机配置
[group('nix')]
show-config config host='unix':
    nix eval --json .#nixosConfigurations.{{host}}.config.{{config}} | jq

# 显示home-manager配置
[group('nix')]
show-hm-config config host='unix' user='usu171':
    nix eval --json .#nixosConfigurations.{{host}}.config.home-manager.users.{{user}}.{{config}} | jq

# 显示iso安装介质配置
[group('nix')]
show-iso-config config:
  nix eval --json --impure --expr 'let flake = builtins.getFlake (toString ./.); cfg = flake.nixosConfigurations.installer; final = cfg.extendModules { modules = [ cfg.config.image.modules.myinstaller ]; }; in final.config.{{config}} ' | jq

# 显示主机 nixpkgs flake source 路径
[group('nix')]
show-flake-source hostname='':
    nix eval --raw .#nixosConfigurations.{{ if hostname == "" { default_host } else { hostname } }}.config.nixpkgs.flake.source

# nix-instantiate --eval --expr '<nixpkgs>'
# nix-instantiate --eval --expr 'builtins.nixPath'
# echo $NIX_PATH
# nix registry list
# nix flake metadata
# nix flake metadata nixpkgs

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
upp input='nixpkgs':
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
