{ username, ... }:

{
  users.groups.i2c = { };
  # users.groups.input = { };

  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [
      "networkmanager"
      "wheel"
      "i2c"
      "input"
    ];
    subUidRanges = [
      {
        startUid = 100000;
        count = 65536;
      }
    ];
    subGidRanges = [
      {
        startGid = 100000;
        count = 65536;
      }
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB1fuSzqGeGlCiVaPm5cY3EgMcc5yxC5+aQ3WLx5G/KE usu171@foxmail.com"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP3Xwqd+r4gYigNUBjN7zA6QfwIl7vccWgUM288/ZcEW usu171@foxmail.com"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID/HEs2+LpWkDolvPUw1JZebYloD0til/YfOnTL3U6An usu171@unix"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINrzG9OZps+ttyStuQeBGNzs1Dpx+0aeZQQ48ckIiWez usu171@nixos"
    ];
  };
}
