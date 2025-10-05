# Discord feature

{ config, lib, pkgs, ... }:
with lib;
let cfg = config.features.games.discord;
in {
  options.features.games.discord.enable =
    mkEnableOption "Enable discord configuration";

  # If discord is enabled, apply these settings
  config = mkIf cfg.enable {

    # Installs discord
    home.packages = with pkgs; [ discord-ptb ];
  };
}

