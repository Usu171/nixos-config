{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    # 浏览器
    google-chrome
    microsoft-edge

    # 终端
    kitty
    ghostty

    fuzzel

    # 主题设置需要
    matugen
    adw-gtk3
    kdePackages.qt6ct

    # GUI
    kdePackages.kate
    kdePackages.dolphin
    kdePackages.gwenview
    nautilus

    # theme
    bibata-cursors
    papirus-icon-theme

    splayer
    easyeffects
    libqalculate

    # 截图
    satty
  ];
}
