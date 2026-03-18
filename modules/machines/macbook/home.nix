{ config, pkgs, lib, ... }:

{
  imports = [
    ../../home/meta/cli.nix
    ../../home/meta/gui-darwin.nix
  ];

  home.packages = with pkgs; [ tokei ];

  programs.mysql = {
    enable = false;
    runAtLoad = true;
  };
  programs.redis = {
    enable = false;
    runAtLoad = true;
  };
  programs.rabbitmq = {
    enable = false;
    runAtLoad = true;
  };
  programs.postgres = {
    enable = true;
    runAtLoad = true;
  };
}
