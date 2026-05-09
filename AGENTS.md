# AGENTS.md

## Scope
- This repo is a single Nix flake for two `x86_64-linux` hosts: `unix` and `nixos`. The real top-level entrypoints are `flake.nix` outputs `nixosConfigurations.unix` and `nixosConfigurations.nixos`.

## Verify Changes
- Format with `nix fmt`.
- Run repo checks with `nix flake check`.
- `nix flake check` includes treefmt validation and `deploy-rs` checks from `flake.nix`; use it as the default verification step.

## Host Boundaries
- Host wiring lives in `hosts/<name>/default.nix`; each host imports one system profile and one host-specific package set.
- System-wide shared behavior is under `modules/shared/`.
- Host system profiles are `modules/profiles/unix.nix` and `modules/profiles/nixos.nix`.
- Home Manager entrypoints are `home/profiles/unix.nix` and `home/profiles/nixos.nix`.
- `unix` Home Manager imports `home/dotfiles.nix`, which recursively links `dotfiles/.config` and `dotfiles/.local/share` into the home directory. Changes under `dotfiles/` affect the `unix` profile broadly.
- `nixos` does not import `home/dotfiles.nix`; it only links `dotfiles/.config/nvim`.

## Commands And Tooling
- `programs.nh.flake` is pinned to `${homeDirectory}/nixos-config` in `modules/shared/nix.nix`; prefer `nh` for local rebuild/switch workflows when touching machine config.
- `deploy-rs` is configured in `flake.nix` for both hosts (`deploy.nodes.unix` and `deploy.nodes.nixos`) with remote builds and `root` activation.
- The default dev shell only adds `deploy-rs`; enter it with `nix develop` if you need the deploy CLI.

## Repo-Specific Gotchas
- Do not change the `system.stateVersion` or `home.stateVersion` values unless the task explicitly requires a migration.
- `modules/shared/packages.nix` enables unfree packages globally and provides common CLI/editor tooling; package additions that should apply to both hosts usually belong there, not in a host file.
- `packages/unix.nix` contains a local override for `programs.clash-verge` service capabilities and startup cleanup. Be careful editing or replacing that block; it is compensating for an upstream module gap.
- VS Code workspace settings point `nixd` option introspection at `nixosConfigurations.unix`, so editor diagnostics may reflect `unix` by default even when you are changing shared code or the `nixos` host.
