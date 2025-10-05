# Minecraft feature

{ config, lib, pkgs, ... }:
with lib;
let cfg = config.features.games.minecraft;
in {
  options.features.games.minecraft.enable =
    mkEnableOption "Enable minecraft configuration";

  # If minecraft is enabled, apply these settings
  config = mkIf cfg.enable {

    # Installs discord
    home.packages = with pkgs; [ prismlauncher ];
  };
}

