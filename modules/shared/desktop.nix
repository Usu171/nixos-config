_:

{
  hardware.graphics.enable = true;

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.gnome.gnome-keyring.enable = true;
  security.pam.services = {
    login.enableGnomeKeyring = true;
    greetd.enableGnomeKeyring = true;
    gdm.enableGnomeKeyring = true;
    sddm.enableGnomeKeyring = true;
  };
}
