# Shared configuration variables between home-manager and nixos (system)
{ lib, ... }:
with lib; {
  # This sets the desktop feature, which is setup between home-manager and the nixos system
  options.features.desktop.type = mkOption {
    type = types.enum [ "kde" "hyprland" "end4" "none" ];
    default = "none";
    description = "Which desktop environment to enable";
  };
}
