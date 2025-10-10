# Alacritty feature

{ config, lib, inputs, pkgs, ... }:
with lib;
let cfg = config.features.cli.nvim;
in {
  options.features.cli.alacritty.enable =
    mkEnableOption "Enable alacritty configuration";

  # If alacritty is enabled, apply these settings
  config = mkIf cfg.enable {

    # Adds the alacritty dotfiles
    home.file.".config/alacritty/" = {
      source = "${inputs.dotfiles}/.config/alacritty/";
    };

    # Installs alacritty and its fonts
    home.packages = with pkgs; [
      alacritty

      # Fonts
      nerd-fonts.jetbrains-mono
      nerd-fonts.meslo-lg
    ];
  };
}

