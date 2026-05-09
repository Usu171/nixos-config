{ pkgs, ... }:

{
  environment.systemPackages = [
    (
      let
        base = pkgs.appimageTools.defaultFhsEnvArgs;
      in
      pkgs.buildFHSEnv (
        base
        // {
          name = "fhs";
          targetPkgs =
            pkgs:
            (base.targetPkgs pkgs)
            ++ (with pkgs; [
              pkg-config

              stdenv.cc.cc.lib
              zlib
              openssl
              icu
              libuv
              curl
              libxml2
              xz
              bzip2
              zstd

              glibc
              glib
              libnghttp2
              brotli
              c-ares
              libssh2

              stdenv.cc.cc.lib
              zlib
              openssl
              icu
              libuv
              curl
              libxml2
              xz
              bzip2
              zstd

              glibc
              glib
              libnghttp2
              brotli
              c-ares
              libssh2

              fontconfig
              freetype
              libglvnd
              dbus
              libX11
              libxt
              libxau
              libxcb
              libxext
              libxft
              xcbutil
              xcbutilimage
              xcbutilkeysyms
              xcbutilrenderutil
              xcbutilwm
              libxkbcommon
              libXdmcp
              libXrender
              libxscrnsaver
              libSM
              libICE
              libGL
              libGLU
              mesa

              libxcrypt-legacy
              motif
            ]);
          profile = "export FHS=1";
          runScript = "zsh";
          extraOutputsToInstall = [ "dev" ];
        }
      )
    )
  ];
}
