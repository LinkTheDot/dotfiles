{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    claude-code
    curl
    fish
    git
    htop
    killall
    neovim
    ntfs3g
    vim
    wget
    lsb-release
    pciutils
    usbutils
  ];
}
