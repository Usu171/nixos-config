{ pkgs, ... }:

{
  # MIME KDE
  environment.etc."xdg/menus/applications.menu".source =
    "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  # protal
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
      # kdePackages.xdg-desktop-portal-kde
    ];
    # config = {
    #   common = {
    # default = "kde";
    # "org.freedesktop.impl.portal.FileChooser" = "kde";
    # };
    # niri = {
    # default = lib.mkForce "gnome";
    # "org.freedesktop.impl.portal.FileChooser" = lib.mkForce "kde";
    # };
    # };
  };

  # environment.variables = {
  # };

  environment.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    TERMINAL = "kitty";
    # GTK_USE_PORTAL = "1";
  };
}
