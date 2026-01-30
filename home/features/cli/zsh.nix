# ZSH feature

{ config, lib, inputs, osConfig, pkgs, ... }:
with lib;
let cfg = config.features.cli.zsh;
in {
  options.features.cli.zsh.enable =
    mkEnableOption "Enable extended zsh configuration";

  # If ZSH is enabled, apply these settings
  config = mkIf cfg.enable {

    ### Removed: made zsh completely declarative (this diverges from the .dotfiles) ###
    # Adds our dotfiles
    # home.file.".zshrc.local" = { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.zshrc"; };
    home.file.".p10k.zsh" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/.dotfiles/.p10k.zsh";
    };

    # Add powerlevel10k package
    home.packages = with pkgs; [ zsh-powerlevel10k ];

    # Creates a nix managed .zshrc rather than our dotfile
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        grep = "rg";
        cat = "bat";
        htop = "htop -t";
        zoxideHist = "zoxide query -l -s | less";
        reload-zsh = "source ~/.zshrc";
        edit-zsh = "nvim ~/.zshrc";
        rebuild =
          "sudo nixos-rebuild switch --flake /home/ant/nix#${osConfig.networking.hostName}";
        remove-old = "sudo nix-collect-garbage --delete-old";
        update-dotfiles =
          "sudo nix flake update dotfiles --flake /home/ant/nix";
      };

      plugins = [{
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }];

      initContent = ''
        eval "$(zoxide init --cmd cd zsh)" # replaces cd
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      '';

      # initContent = ''
      #   # Source the custom dotfiles
      #   if [ -f ~/.zshrc.local ]; then
      #     source ~/.zshrc.local
      #   fi
      # '';
    };

  };
}

