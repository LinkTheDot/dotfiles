{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
    git
    nixpkgs-fmt
  ];

  programs.fish.enable = true;
} 
