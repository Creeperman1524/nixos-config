# Default features that are always enabled

{ pkgs, ... }: {
  imports = [ ./zsh.nix ./nvim.nix ./neofetch.nix ./alacritty.nix ];

  # Better cd 
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # Better ls
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    extraOptions = [
      "--color=always"
      "--long"
      "--git"
      "--no-filesize"
      "--icons=always"
      "--no-time"
      "--no-user"
      "--no-permissions"
    ];
  };

  # Better cat
  programs.bat.enable = true;

  # Fuzzy finder
  programs.fzf.enable = true;

  # Core cli utilities
  home.packages = with pkgs; [ coreutils htop openssl ripgrep tldr which zip ];
}

