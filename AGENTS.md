# AGENTS.md

## Entry Points
- `flake.nix` only imports `./outputs`; the real flake wiring is in `outputs/default.nix`.
- The host entrypoints are `nixosConfigurations.unix` and `nixosConfigurations.nixos` in `outputs/hosts.nix`.

## Verify
- Run `nix fmt` before `nix flake check` when you touch formatting.
- Use `nix flake check` as the default verification step; it includes treefmt checks and `deploy-rs` checks from `outputs/checks.nix`.
- The dev shell only adds `deploy-rs`; use `nix develop` if you need the deploy CLI.

## Layout
- Host wiring lives in `hosts/<name>/default.nix`.
- Shared NixOS behavior lives under `modules/shared/`; common packages and nix settings are in `modules/shared/packages.nix` and `modules/shared/nix.nix`.
- Host profiles are `modules/profiles/unix.nix` and `modules/profiles/nixos.nix`.
- Home Manager entrypoints are `home/profiles/unix.nix` and `home/profiles/nixos.nix`.

## Gotchas
- `unix` imports `home/dotfiles.nix`, so edits under `dotfiles/.config` or `dotfiles/.local/share` affect that profile broadly.
- `nixos` only links `dotfiles/.config/nvim`.
- Do not change `system.stateVersion` or `home.stateVersion` unless a migration is required.
- `programs.nh.flake` is pinned to `${homeDirectory}/nixos-config`; use `nh` for local rebuild/switch workflows.
- `packages/unix.nix` has a manual `clash-verge` service override to keep DNS binding and stale tun cleanup working; edit it carefully.
- VS Code's nixd points option introspection at `nixosConfigurations.unix`, so diagnostics may default to `unix`.
