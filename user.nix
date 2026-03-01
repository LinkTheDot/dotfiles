{ pkgs, ... }:

{
  users.users.looank = {
    isNormalUser = true;
    home = "/home/looank";
    extraGroups = [ "wheel" "docker" "networkmanager" ];
    shell = pkgs.fish;
  };
}
