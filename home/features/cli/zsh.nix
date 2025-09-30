# ZSH feature

{ config, lib, inputs, osConfig, ... }:
with lib;
let cfg = config.features.cli.zsh;
in {
  options.features.cli.zsh.enable =
    mkEnableOption "Enable extended zsh configuration";

  # If ZSH is enabled, apply these settings
  config = mkIf cfg.enable {

    # Adds our dotfiles
    home.file.".zshrc.local" = { source = "${inputs.dotfiles}/.zshrc"; };
    # home.file.".p10k.zsh" = { source = "${inputs.dotfiles}/.p10k.zsh"; };

    # Creates a nix managed .zshrc, which sources our dotfiles
    programs.zsh = {
      enable = true;

      shellAliases = {
        grep = "rg";
        cat = "bat";
        rebuild =
          "sudo nixos-rebuild switch --flake /home/ant/nix#${osConfig.networking.hostName}";
      };

      initContent = ''
        # Source the custom dotfiles
        if [ -f ~/.zshrc.local ]; then
          source ~/.zshrc.local
        fi
      '';
    };

  };
}

