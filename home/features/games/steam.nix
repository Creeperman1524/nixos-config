# steam feature

{ config, lib, pkgs, ... }:
with lib;
let cfg = config.features.games.steam;
in {
  options.features.games.steam.enable =
    mkEnableOption "Enable steam configuration";

  # If steam is enabled, apply these settings
  config = mkIf cfg.enable {

    # Installs steam
    home.packages = with pkgs; [ steam ];
  };
}

