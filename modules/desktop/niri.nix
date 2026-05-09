{ homeDirectory, pkgs, ... }:

{
  services.xserver.desktopManager.runXdgAutostartIfNone = true;

  environment.systemPackages = with pkgs; [
    bibata-cursors
  ];

  programs.xwayland.enable = true;
  programs.niri = {
    enable = true;
    useNautilus = true;
  };

  services.desktopManager.plasma6.enable = true;

  # services.greetd = {
  #   enable = true;
  #   settings = rec {
  #     initial_session = {
  #       command = "${config.programs.niri.package}/bin/niri-session";
  #       user = username;
  #     };
  #     default_session = initial_session;
  #   };
  # };

  programs.dank-material-shell.greeter = {
    enable = true;
    compositor = {
      name = "niri";
      customConfig = ''
        hotkey-overlay {
          skip-at-startup
        }

        environment {
          DMS_RUN_GREETER "1"
          XCURSOR_THEME "Bibata-Modern-Ice"
          XCURSOR_SIZE "24"
        }

        input {
          keyboard {
            xkb {
              layout "us"
            }

            numlock
          }
        }

        cursor {
          xcursor-theme "Bibata-Modern-Ice"
          xcursor-size 24
        }

        gestures {
          hot-corners {
            off
          }
        }

        layout {
          background-color "#000000"
        }
      '';
    };
    configHome = homeDirectory;
  };
}
