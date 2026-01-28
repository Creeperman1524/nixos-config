# This is for home-manager user-level configuruation of hyprland

{ config, lib, pkgs, ... }:
with lib;
let isEnabled = config.features.desktop.type == "hyprland";
in {
  config = mkIf isEnabled {
    home.packages = with pkgs; [
      waybar
      rofi
      firefox
      kitty
      alacritty
      dunst
      nemo
      xdg-desktop-portal-hyprland
      # qt5-wayland
      # qt6-wayland
      hyprlock
    ];

    programs.kitty.enable = true;

    # Disabled to keep Home Manager from touching the hyprland config files
    # wayland.windowManager.hyprland = { enable = true; };
  };
}

