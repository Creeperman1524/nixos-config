# System configuration for the current machine
{ pkgs, ... }:

{
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

  environment.systemPackages = with pkgs; [ curl wget git vim ];
}
