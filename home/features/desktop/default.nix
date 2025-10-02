{ pkgs, ... }: {
  imports = [ ./kde.nix ./hyprland.nix ];

  home.packages = with pkgs; [ ];
}

