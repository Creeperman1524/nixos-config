{ pkgs, ... }: {
  imports = [ ./obsidian.nix ];

  home.packages = with pkgs; [ ];
}

