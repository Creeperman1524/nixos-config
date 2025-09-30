# User configurations of ant for da-laptop

{ config, hostname, ... }: {
  imports = [ ../common ../features/cli ./home.nix ];

  features = {
    cli = {
      zsh.enable = true;
      nvim.enable = true;
      neofetch.enable = true;
    };
  };
}

