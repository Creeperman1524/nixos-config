# Nvim feature

{ config, lib, inputs, pkgs, ... }:
with lib;
let cfg = config.features.cli.nvim;
in {
  options.features.cli.nvim.enable = mkEnableOption "Enable nvim configuration";

  # If nvim is enabled, apply these settings
  config = mkIf cfg.enable {

    # Adds our dotfiles
    home.file.".config/nvim" = {
      source = "${inputs.dotfiles}/.config/nvim";
      recursive = true;
    };

    # Installs all necessary packages
    home.packages = with pkgs; [
      neovim
      ripgrep
      gnumake
      fzf
      nodejs
      python3
      unzip
      gcc
      yarn
      cargo
    ];
  };
}

