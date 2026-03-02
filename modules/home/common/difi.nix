{ config, pkgs, lib, ... }:

let
  difi = pkgs.buildGoModule {
    pname = "difi";
    version = "0.1.8";

    src = pkgs.fetchFromGitHub {
      owner = "oug-t";
      repo = "difi";
      rev = "v0.1.8";
      sha256 = "sha256-N56gETOeCOA9ui+QScsJdmccEGQzk22y1gsOoyxPpw4=";
    };

    vendorHash = "sha256-TctoBYfA/+IA2Rjfyn/hVM+wdU5FCC5lZn/Dk/UBfw4=";

    subPackages = [ "cmd/difi" ];
  };
in
{
  home.packages = [ difi ];
}
