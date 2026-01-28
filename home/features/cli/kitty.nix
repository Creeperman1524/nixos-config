# kitty feature

{ config, lib, pkgs, ... }:
with lib;
let cfg = config.features.cli.kitty;
in {
  options.features.cli.kitty.enable =
    mkEnableOption "Enable kitty configuration";

  # If kitty is enabled, apply these settings
  config = mkIf cfg.enable {

    # Adds the kitty dotfiles
    home.file.".config/kitty" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/.dotfiles/.config/kitty";
    };

    # Installs kitty and its fonts
    home.packages = with pkgs;
      [
        # kitty

        # Fonts
        nerd-fonts.jetbrains-mono
      ];
  };
}

