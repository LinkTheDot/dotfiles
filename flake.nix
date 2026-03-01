{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-wsl, home-manager, nix-darwin, nur, ... }@inputs:
    let
      localConfig = import ./modules/users/default.nix {
        sourceRoot = ./.;
      };

      mkUserConfig = { system }:
        localConfig.getUserConfig { inherit system; };

      mkSystemConfig = name: localConfig.getSystemConfig // {
        hostName = name;
      };

      nixpkgsFor = system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ nur.overlays.default ];
      };

      mkHome = { name, system }:
        let
          isDarwin = builtins.elem system [ "aarch64-darwin" "x86_64-darwin" ];
          osModules =
            if isDarwin then [
              ./modules/home/darwin.nix
            ] else [
              ./modules/home/linux.nix
            ];
        in
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgsFor system;
          modules = osModules ++ [
            ./modules/home/default.nix
            ./modules/machines/${name}/home.nix
          ];
          extraSpecialArgs = {
            inherit inputs;
            userConfig = mkUserConfig { inherit system; };
            systemConfig = mkSystemConfig name;
            sourceRoot = self;
          };
        };

      mkDarwinSystem = name:
        nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./modules/system/darwin/default.nix
            ./modules/machines/${name}/system.nix
          ];
          specialArgs = {
            inherit inputs;
            userConfig = mkUserConfig { system = "aarch64-darwin"; };
            systemConfig = mkSystemConfig name;
            sourceRoot = self;
          };
        };
    in
    {
      homeConfigurations = {
        "workmac" = mkHome { name = "macbook"; system = "aarch64-darwin"; };
        "looank" = mkHome { name = "personal_computer"; system = "x86_64-linux"; };
      };

      darwinConfigurations = {
        "workmac" = mkDarwinSystem "macbook";
      };

      nixosConfigurations = {
        "personal_computer" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            nixos-wsl.nixosModules.default
            ./modules/machines/personal_computer/system.nix
          ];
          specialArgs = {
            inherit inputs;
            userConfig = mkUserConfig { system = "x86_64-linux"; };
            systemConfig = mkSystemConfig "personal_computer";
            sourceRoot = self;
          };
        };
      };
    };
}
