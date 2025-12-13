# This is for nixos system-level configuruation of end4

{ config, lib, pkgs, ... }:
with lib;
let isEnabled = config.features.desktop.type == "end4";
in {
  config = mkIf isEnabled {
    # https://github.com/soymou/illogical-flake
    services.geoclue2.enable = true; # For QtPositioning
    # fonts.packages = with pkgs; [
    #   rubik
    #   nerd-fonts.ubuntu
    #   nerd-fonts.jetbrains-mono
    # ];
  };
}

