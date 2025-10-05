# Obsidian feature

{ config, lib, pkgs, ... }:
with lib;
let cfg = config.features.school.obsidian;
in {
  options.features.school.obsidian.enable =
    mkEnableOption "Enable obsidian configuration";

  # If obsidian is enabled, apply these settings
  config = mkIf cfg.enable {

    # Installs obsidian
    home.packages = with pkgs; [ obsidian ];

    # TODO: cron job of automatic backup?
  };
}

