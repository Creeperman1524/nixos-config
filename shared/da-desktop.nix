# Set home-manager and system configurations
{
  imports = [ ./definition.nix ];

  # Set the desktop environment for this system
  features.desktop.type = "hyprland";
}
