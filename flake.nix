{  
  description = "DTizzy's NixOS Flake";


  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-small.url = "github:nixos/nixpkgs/nixos-unstable-small"; 

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
 
    schizofox.url = "github:schizofox/schizofox";
    schizofox.inputs.nixpkgs.follows = "nixpkgs-small";
   };

  outputs = { self, nixpkgs, home-manager, hyprland, ... } @inputs: {

    # Replace .nixos with hostname if changed from default
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };      

      modules = [
	./system

	home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # Replace dorian with your own username
            home-manager.users.dorian = import ./home/home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }

          #{
          #  wayland.windowManager.hyprland.enable = true;
          #  wayland.windowManager.hyprland.package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
          #}

      ];


    };
  };
}
