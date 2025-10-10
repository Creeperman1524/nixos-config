# User configurations of ant for da-laptop

{ config, hostname, inputs, ... }: {
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
    ../common
    ../features/cli
    ../features/desktop
    ../features/games
    ../features/school
    ./home.nix
  ];

  features = {
    cli = {
      zsh.enable = true;
      nvim.enable = true;
      neofetch.enable = true;
      alacritty.enable = true;
    };
    desktop = {
      kde = {
        enable = true;
        nightLight = false;
        krunner = true; # KDE spotlight search
      };
      hyprland.enable = false;
      rofi.enable = false; # system spotlight search
    };
    school = { obsidian.enable = true; };
    games = {
      discord.enable = true;
      minecraft.enable = true;
      steam.enable = true;
    };
  };

  # https://github.com/taj-ny/nix-config/blob/32750667fde9e97c801aeecf2f33256f23c23b25/home/config/_shared/programs/firefox/default.nix
}

