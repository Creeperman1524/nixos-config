# User configurations of ant for da-laptop

{ config, hostname, inputs, ... }: {
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
    ../common
    ../features/cli
    ../features/desktop
    ./home.nix
  ];

  features = {
    cli = {
      zsh.enable = true;
      nvim.enable = true;
      neofetch.enable = true;
    };
    desktop = {
      kde.enable = true;
      hyprland.enable = false;
    };
  };
}

