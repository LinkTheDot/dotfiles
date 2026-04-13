{ config, pkgs, lib, userConfig ? { }, systemConfig ? { }, ... }:

let
  githubUser = userConfig.username;
  publicKeysFile = builtins.readFile (pkgs.fetchurl {
    url = "https://github.com/LinkTheDot.keys";
    sha256 = "M2WlzzEtbO5nMTU/nsfOpCw/ayjsKk25+04lDSE81jE=";
  });
  publicKeys = lib.splitString "\n" (lib.removeSuffix "\n" publicKeysFile);
in
{
  imports = [
    ./hardware-configuration.nix
    ../../system/meta/cli-nixos.nix
    ../../system/nixos/docker.nix
  ];

  # services.dnsmasq-resolver.enable = true;

  # Tailscale as exit node and route advertiser for remote LAN access
  # services.tailscale = {
  #   useRoutingFeatures = "server";
  #   extraUpFlags = [
  #     "--exit-node="
  #     "--accept-routes=false"
  #     "--advertise-exit-node"
  #     "--advertise-routes=192.168.1.0/24"
  #   ];
  # };

  networking.hostName = "loonkuter";

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  users.users.looank = {
    isNormalUser = true;
    home = "/home/looank";
    extraGroups = [ "wheel" "docker" "networkmanager" ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = publicKeys;
  };

  nix.settings = {
    substituters = [
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
    download-buffer-size = 524288000;
  };

  environment.sessionVariables = { };

  programs.fish = {
    enable = true;
    shellAliases = {
      vim = "nvim";
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05";
}
