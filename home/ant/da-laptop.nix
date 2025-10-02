# User configurations of ant for da-laptop

{ config, hostname, inputs, ... }: {
  imports = [ ../common ../features/cli ../features/desktop ./home.nix ];

  features = {
    cli = {
      zsh.enable = true;
      nvim.enable = true;
      neofetch.enable = true;
    };
    desktop = { hyprland.enable = false; };
  };
}

