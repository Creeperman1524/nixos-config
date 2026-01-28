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

    # Adds the hyprland dotfiles
    home.file.".config/hypr" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/.dotfiles/.config/hypr";
    };

    # Disabled to keep Home Manager from touching the config files
    # programs.kitty.enable = true;
    # wayland.windowManager.hyprland = { enable = true; };
  };
}

