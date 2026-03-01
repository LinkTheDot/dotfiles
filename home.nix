{ pkgs, ... }:

{
  imports = [
    ./neovim.nix
  ];

  home.username = "looank";
  home.homeDirectory = "/home/looank";
  home.stateVersion = "24.05";
}
