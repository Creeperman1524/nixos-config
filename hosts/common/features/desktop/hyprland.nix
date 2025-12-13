# This is for nixos system-level configuruation of hyprland

{ config, lib, ... }:
with lib;
let isEnabled = config.features.desktop.type == "hyprland";
in {
  config = mkIf isEnabled {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
}

