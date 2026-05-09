{
  config,
  pkgs,
  lib,
  ...
}:

{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-gtk
        qt6Packages.fcitx5-configtool
        (fcitx5-rime.override {
          rimeDataPkgs = [ rime-ice ];
        })
      ];
      settings = {
        globalOptions = {
          Hotkey = {
            EnumerateWithTriggerKeys = true;
            EnumerateSkipFirst = false;
            ModifierOnlyKeyTimeout = 250;
          };
          "Hotkey/TriggerKeys" = {
            "0" = "Super+space";
            "1" = "Zenkaku_Hankaku";
            "2" = "Hangul";
          };
          "Hotkey/ActivateKeys"."0" = "Hangul_Hanja";
          "Hotkey/DeactivateKeys"."0" = "Hangul_Romaja";
          "Hotkey/AltTriggerKeys"."0" = "Shift_L";
          "Hotkey/EnumerateGroupForwardKeys"."0" = "Super+space";
          "Hotkey/EnumerateGroupBackwardKeys"."0" = "Shift+Super+space";
          "Hotkey/PrevPage"."0" = "Up";
          "Hotkey/NextPage"."0" = "Down";
          "Hotkey/PrevCandidate"."0" = "Shift+Tab";
          "Hotkey/NextCandidate"."0" = "Tab";
          "Hotkey/TogglePreedit"."0" = "Control+Alt+P";

          Behavior = {
            ActiveByDefault = false;
            resetStateWhenFocusIn = "No";
            ShareInputState = "All";
            PreeditEnabledByDefault = true;
            ShowInputMethodInformation = true;
            showInputMethodInformationWhenFocusIn = false;
            CompactInputMethodInformation = true;
            ShowFirstInputMethodInformation = true;
            DefaultPageSize = 5;
            OverrideXkbOption = false;
            CustomXkbOption = "";
            EnabledAddons = "";
            DisabledAddons = "";
            PreloadInputMethod = true;
            AllowInputMethodForPassword = false;
            ShowPreeditForPassword = false;
            AutoSavePeriod = 30;
          };
        };
        addons.classicui.globalSection.Theme = "Matugen";
        inputMethod = {
          GroupOrder."0" = "Default";
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "us";
            DefaultIM = "rime";
          };
          "Groups/0/Items/0".Name = "keyboard-us";
          "Groups/0/Items/1".Name = "rime";
        };
      };
    };
  };

  home.activation.redeployRime = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    user_rime_dir="$HOME/.local/share/fcitx5/rime"
    shared_rime_dir="${config.home.path}/share/rime-data"
    build_rime_dir="$user_rime_dir/build"

    if [ -d "$user_rime_dir" ] && [ -d "$shared_rime_dir" ]; then
      rm -rf "$build_rime_dir"
      ${pkgs.librime}/bin/rime_deployer --build "$user_rime_dir" "$shared_rime_dir" "$build_rime_dir"
      ${pkgs.systemd}/bin/systemctl --user restart fcitx5-daemon.service || true
    fi
  '';

}
