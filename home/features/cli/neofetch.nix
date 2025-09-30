# Neofetch feature

{ config, lib, inputs, pkgs, ... }:
with lib;
let cfg = config.features.cli.nvim;
in {
  options.features.cli.neofetch.enable =
    mkEnableOption "Enable neofetch configuration";

  # If neofetch is enabled, apply these settings
  config = mkIf cfg.enable {

    # Adds our dotfiles
    home.file.".config/neofetch" = {
      source = "${inputs.dotfiles}/.config/neofetch";
      recursive = true;
    };

    # Installs neofetch
    home.packages = with pkgs; [ neofetch ];
  };
}

