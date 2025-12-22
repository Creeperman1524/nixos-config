# Rofi feature

{ config, lib, pkgs, ... }:
with lib;
let cfg = config.features.desktop.rofi;
in {
  options.features.desktop.rofi.enable =
    mkEnableOption "Enable rofi configuration";

  # If rofi is enabled, apply these settings
  config = mkIf cfg.enable {

    # Installs rofi and its packages
    home.packages = with pkgs; [ rofi ];

    # Clones the rofi themes from https://github.com/adi1090x/rofi.git
    # and places it into $HOME/.config/rofi/custom
    home.activation.cloneRofiThemes =
      lib.hm.dag.entryAfter [ "writeBoundary" ] ''
         ROFI="$HOME/.config/rofi"
         mkdir -p "$ROFI"

         if [ ! -d "$ROFI/launchers" ]; then
        	 echo "Cloning rofi repository..."
        	 ${pkgs.git}/bin/git clone --depth=1 https://github.com/adi1090x/rofi.git "$ROFI"/temp
        	 mv "$ROFI"/temp/files/* "$ROFI"
        	 rm -rf "$ROFI"/temp
         fi

         # Edit the configuration for type-2 style-2
         sed -i s/colors\\/.\*/colors\\/catppuccin.rasi\"/g "$ROFI"/launchers/type-2/shared/colors.rasi
         sed -i 's/"[^"]*"/"JetBrainsMono Nerd Font Propo 11"/' "$ROFI"/launchers/type-2/shared/fonts.rasi
         sed -i s/theme=.*/theme='style-2'/g "$ROFI"/launchers/type-2/launcher.sh
      '';

    # Symlinks a custom launcher (from above) to $HOME/.config/rofi/launcher.sh
    # This is what should be called when you press the keybind
    home.file.".config/rofi/launcher.sh" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/.config/rofi/launchers/type-2/launcher.sh";
    };
  };
}

