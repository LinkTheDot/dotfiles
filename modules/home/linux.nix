{ config, pkgs, lib, ... }:

{
  imports = [
    ./linux/mycli.nix
  ];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = false;
    # pinentry.package = pkgs.pinentry-gtk2;
  };

  home.packages = with pkgs; [
    pkg-config
    openssl.dev
  ];

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
