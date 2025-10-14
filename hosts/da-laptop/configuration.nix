# System configuration for the current machine
{ pkgs, ... }:
let
  sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "black_hole"; # The name of the theme you most loved
    # themeConfig = {
    #   Background =
    #     "path/to/background.jpg"; # This theme also accepts videos
    # };
  };
in {
  imports = [ ./hardware-configuration.nix ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Do not change this after install
  system.stateVersion = "25.05";

  networking.hostName = "da-laptop";
  networking.networkmanager.enable = true;

  # Enables us to use flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # For virtual box
  virtualisation.virtualbox.guest.enable = true;
  networking.nameservers = [ "8.8.8.8" ];

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
    settings.PasswordAuthentication = false;
  };

  # Enable sddm login screen
  services.displayManager.sddm = {
    enable = true;
    extraPackages = with pkgs; [ sddm-astronaut ];

    theme = "sddm-astronaut-theme";
    settings = { Theme = { Current = "sddm-astronaut-theme"; }; };
  };

  # Enable plasma
  services.desktopManager.plasma6.enable = true;

  # Enable hyprland
  # programs.hyprland = {
  #   enable = true;
  #   xwayland.enable = true;
  # };
  #
  # services.displayManager.sddm = {
  #   enable = true;
  #   wayland.enable = true;
  #   enableHidpi = true;
  # };

  services.journald.extraConfig = "SystemMaxUse=100M";

  environment.systemPackages = with pkgs; [
    curl
    wget
    git
    vim
    sddm-astronaut
    kdePackages.qtmultimedia
  ];
}
