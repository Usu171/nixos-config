_:

{
  services.cockpit = {
    enable = true;
    openFirewall = true;
    port = 9091;

    # settings = {
    #   WebService = {
    #   AllowUnencrypted = true;
    #   };
    # };
  };
}
