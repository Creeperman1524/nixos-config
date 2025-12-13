# This is for nixos system-level configuruation of kde-plasma

{ config, lib, ... }:
with lib;
let isEnabled = config.features.desktop.type == "kde";
in {
  config = mkIf isEnabled { services.desktopManager.plasma6.enable = true; };
}

