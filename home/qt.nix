{
  config,
  ...
}:

{
  qt = {
    enable = true;
    # platformTheme = { # 全局qt6ct，会导致KDE崩溃
    #   name = "qt6ct";
    #   package = pkgs.kdePackages.qt6ct;
    # };
    # style = {
    #   name = "Breeze";
    #   package = pkgs.kdePackages.breeze;
    # };
    qt6ctSettings = {
      Appearance = {
        color_scheme_path = "${config.home.homeDirectory}/.config/qt6ct/colors/matugen.conf";
        custom_palette = true;
        icon_theme = "Papirus-Dark";
        standard_dialogs = "kde";
        style = "Breeze";
      };
      Fonts = {
        fixed = ''"Noto Sans,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"'';
        general = ''"Noto Sans,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"'';
      };
      Interface = {
        activate_item_on_single_click = 1;
        buttonbox_layout = 0;
        cursor_flash_time = 1000;
        dialog_buttons_have_icons = 1;
        double_click_interval = 400;
        keyboard_scheme = 2;
        menus_have_icons = true;
        show_shortcuts_in_context_menus = true;
        toolbutton_style = 4;
        underline_shortcut = 1;
        wheel_scroll_lines = 3;
      };
      Troubleshooting = {
        force_raster_widgets = 1;
      };
    };
  };
}
