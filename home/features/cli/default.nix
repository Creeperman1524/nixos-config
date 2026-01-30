# Default features that are always enabled

{ config, pkgs, ... }: {
  imports = [ ./zsh.nix ./nvim.nix ./neofetch.nix ./alacritty.nix ./kitty.nix ];

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
  home.packages = with pkgs; [
    coreutils
    htop
    openssl
    ripgrep
    tldr
    tmux
    which
    zip
  ];

  # Symlink tmux dotfiles 
  home.file.".tmuxDotfiles.conf" = {
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.dotfiles/.tmux.conf";
  };

  # Setup tmux plugins through home manager
  programs.tmux = {
    enable = true;

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @plugin 'catppuccin/tmux#v2.1.3'
          set -g @catppuccin_flavour 'mocha'
          set -g @catppuccin_window_status_style "basic"
          set -g @catppuccin_window_text ' #W'
          set -g @catppuccin_window_current_text ' #W'
          set -g @catppuccin_status_background "#{@thm_bg}"
          set -g @catppuccin_window_current_number_color "#{@thm_blue}"
        '';
      }
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-capture-pane-contents 'off' # Saves the contents of the panes
          set -g @resurrect-processes 'ssh' # Saves ssh sessions
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on' # Restores tmux sessions on startup
          set -g @continuum-boot 'on' # Restores tmux on boot
        '';
      }
    ];

    extraConfig = "source-file ~/.tmuxDotfiles.conf";
  };

}
