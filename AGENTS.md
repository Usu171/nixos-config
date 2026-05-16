# AGENTS.md

## Entry Points
- `flake.nix` only imports `./outputs`; the real wiring is in `outputs/default.nix`.
- Main host outputs live in `outputs/hosts.nix`: `nixosConfigurations.unix`, `nixosConfigurations.nixos`, plus an `installer` ISO config.
- Deploy targets are separate from host definitions and live in `outputs/deploy.nix`.

## Verify
- Default local check is `nix flake check`; it runs treefmt checks and `deploy-rs` deploy checks from `outputs/checks.nix`.
- CI only runs `nix flake check --no-build` in `.github/workflows/check.yml`, and ignores `**.md` changes.
- Run `nix fmt` before `nix flake check` when you touch Nix files; `treefmt.nix` enables `nixfmt`, `deadnix`, `statix`, and `typos`.
- `nix develop` only adds the `deploy-rs` CLI.

## Layout
- Host entry modules are `hosts/<name>/default.nix`; shared host composition is in `modules/profiles/unix.nix` and `modules/profiles/nixos.nix`.
- Shared NixOS base is `modules/shared/`; shared package sets are composed from `modules/packages/shared/`.
- Home Manager entrypoints are `home/profiles/unix.nix` and `home/profiles/nixos.nix`.

## Gotchas
- `unix` imports `home/dotfiles.nix`, which recursively links all of `dotfiles/.config` and `dotfiles/.local/share`.
- `nixos` does not use `home/dotfiles.nix`; it only links `dotfiles/.config/nvim` and `dotfiles/.config/zellij/config.kdl`.
- Do not change `system.stateVersion` or `home.stateVersion` unless you are intentionally doing a migration.
- `programs.nh.flake` is pinned to `${homeDirectory}/nixos-config`; prefer `nh` for local switch/rebuild workflows.
- VS Code's `nixd` settings point option introspection at `nixosConfigurations.unix`, so editor diagnostics can default to the `unix` host.
- `modules/services/clash.nix` is opinionated: it fetches Mihomo config from a hard-coded HTTP endpoint into `${homeDirectory}/.local/share/mihomo/config.yaml`, restarts the service after fetch, and the `installer` host can seed that state from `hosts/installer/mihomo/` if that directory exists.
