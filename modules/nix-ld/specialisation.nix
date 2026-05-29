_:

{
  specialisation = {
    nix-ld.configuration = {
      imports = [
        ./base.nix
        ./gui.nix
      ];
    };
  };
}
