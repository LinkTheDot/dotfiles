{ config, pkgs, lib, ... }:

{
  imports = [
    ./karabiner.nix
    ./linearmouse.nix
    ./wallpaper.nix
  ];
}
