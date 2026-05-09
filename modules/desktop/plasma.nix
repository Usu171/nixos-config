{ username, ... }:

{
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = username;
  services.displayManager.sddm.enable = true;

  services.desktopManager.plasma6.enable = true;
}
