{ config, lib, pkgs, ... }:
with lib;
let cfg = config.features.desktop.hyprland;
in {
  options.features.desktop.hyprland.enable = mkEnableOption "hyprland config";

  config = mkIf cfg.enable {
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

    wayland.windowManager.hyprland = { enable = true; };
  };
}

