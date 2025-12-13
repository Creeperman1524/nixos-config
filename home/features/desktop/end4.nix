# This is for home-manager user-level configuruation of end4

# TODO: this is a work in progress

{ config, lib, ... }:
with lib;
let isEnabled = config.features.desktop.type == "end4";
in {
  config = mkIf isEnabled {
    programs.illogical-impulse = {
      enable = true;

      # Customize shell tools (all enabled by default)
      dotfiles = {
        fish.enable = true; # Fish shell with custom config
        kitty.enable = true; # Kitty terminal emulator
        starship.enable = true; # Starship prompt
      };
    };
  };
}

