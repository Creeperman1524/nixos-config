# User configurations of ant for da-desktop

{ config, hostname, inputs, ... }: {
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
    inputs.illogical-flake.homeManagerModules.default
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
      alacritty.enable = false;
      kitty.enable = true;
    };
    # Desktop environments are set system-wide in /shared/HOST
    desktop = {
      kde = {
        nightLight = false;
        krunner = false; # KDE spotlight search
      };
      rofi.enable = true; # system spotlight search
    };
    school = { obsidian.enable = false; };
    games = {
      discord.enable = true;
      minecraft.enable = true;
      steam.enable = true;
    };
  };

  # https://github.com/taj-ny/nix-config/blob/32750667fde9e97c801aeecf2f33256f23c23b25/home/config/_shared/programs/firefox/default.nix
}

