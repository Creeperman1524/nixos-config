# Rofi feature

{ config, lib, pkgs, ... }:
with lib;
let cfg = config.features.desktop.rofi;
in {
  options.features.desktop.rofi.enable =
    mkEnableOption "Enable rofi configuration";

  # If rofi is enabled, apply these settings
  config = mkIf cfg.enable {

    # Installs rofi and its packages
    home.packages = with pkgs; [ rofi ];
  };
}

