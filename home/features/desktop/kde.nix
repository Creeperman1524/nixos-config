# This is for home-manager user-level configuruation of kde-plasma

{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.features.desktop.kde;
  isEnabled = config.features.desktop.type == "kde";
  wallpaper_path = "/home/ant/Pictures/sunset.jpg";
in {
  options.features.desktop.kde.nightLight =
    mkEnableOption "KDE Plasma night light setting";
  options.features.desktop.kde.krunner =
    mkEnableOption "KDE Krunner (spotlight search) config";

  config = mkIf isEnabled {

    # Thanks to https://github.com/AlexNabokikh/nix-config/
    home.packages = with pkgs; [
      # Browser
      firefox

      # KDE specific
      (catppuccin-kde.override {
        flavour = [ "mocha" ];
        accents = [ "blue" ];
      })
      kde-rounded-corners
      kdePackages.kcalc
      # kdePackages.krohnkite # tiling window manager
      kdotool

      # Icons
      # tela-circle-icon-theme
      # monochrome-icons
      beauty-line
    ];

    # For more information on each module: https://github.com/nix-community/plasma-manager/blob/trunk/modules/
    programs.plasma = {
      enable = true;

      # If nothing is specified here, it is reset to its default
      # Make sure to make all changes in here!
      overrideConfig = true;

      fonts = {
        fixedWidth = {
          family = "JetBrainsMono Nerd Font Mono";
          pointSize = 11;
        };
        general = {
          family = "JetBrainsMono Nerd Font Mono";
          pointSize = 11;
        };
        menu = {
          family = "JetBrainsMono Nerd Font Mono";
          pointSize = 11;
        };
        small = {
          family = "JetBrainsMono Nerd Font Mono";
          pointSize = 8;
        };
        toolbar = {
          family = "JetBrainsMono Nerd Font Mono";
          pointSize = 11;
        };
        windowTitle = {
          family = "JetBrainsMono Nerd Font Mono";
          pointSize = 11;
        };
      };

      hotkeys.commands = {
        launcher-rofi = mkIf config.features.desktop.rofi.enable {
          name = "Launch Rofi";
          key = "Alt+Space";
          command = "/home/ant/.config/rofi/launcher.sh";
        };
        launch-alacritty = mkIf config.features.cli.alacritty.enable {
          name = "Launch Alacritty";
          key = "Meta+T";
          command = "alacritty";
        };
        launch-firefox = {
          name = "Launch Firefox";
          key = "Meta+F";
          command = "firefox";
        };
        launch-discord = mkIf config.features.games.discord.enable {
          name = "Launch Discord";
          key = "Meta+D";
          command = "discord";
        };
        launch-obsidian = mkIf config.features.school.obsidian.enable {
          name = "Launch Obsidian";
          key = "Meta+O";
          command = "obsidian";
        };

        move-window-and-focus-to-desktop-1 = {
          name = "Move Window and Focus to Desktop 1";
          key = "Meta+!";
          command = "kde_mv_window 1";
        };
        move-window-and-focus-to-desktop-2 = {
          name = "Move Window and Focus to Desktop 2";
          key = "Meta+@";
          command = "kde_mv_window 2";
        };
        move-window-and-focus-to-desktop-3 = {
          name = "Move Window and Focus to Desktop 3";
          key = "Meta+#";
          command = "kde_mv_window 3";
        };
        move-window-and-focus-to-desktop-4 = {
          name = "Move Window and Focus to Desktop 4";
          key = "Meta+$";
          command = "kde_mv_window 4";
        };
        move-window-and-focus-to-desktop-5 = {
          name = "Move Window and Focus to Desktop 5";
          key = "Meta+%";
          command = "kde_mv_window 5";
        };
        screenshot-region = {
          name = "Capture a rectangular region of the screen";
          key = "Ctrl+Shift+S";
          command = "spectacle --region --nonotify";
        };
        # screenshot-screen = {
        #   name = "Capture the entire desktop";
        #   key = "Meta+Ctrl+S";
        #   command = "spectacle --fullscreen --nonotify";
        # };
      };

      input = {
        keyboard = {
          layouts = [{ layout = "en"; }];
          repeatDelay = 150;
          repeatRate = 40;
        };
        mice = [
          # TODO:
          {
            accelerationProfile = "none";
            name = "Logitech USB Receiver";
            productId = "c547";
            vendorId = "046d";
          }
        ];
        touchpads = [{
          # TODO:
          disableWhileTyping = true;
          enable = true;
          leftHanded = false;
          middleButtonEmulation = true;
          name = "ELAN06A0:00 04F3:3231 Touchpad";
          naturalScroll = true;
          pointerSpeed = 0;
          productId = "3231";
          tapToClick = true;
          vendorId = "04f3";
        }];
      };

      # Spotlight search
      krunner = mkIf cfg.krunner {
        position = "center";
        activateWhenTypingOnDesktop = false;
      };

      # Lock screen/screen saver
      kscreenlocker = {
        appearance.showMediaControls = false;
        appearance.alwaysShowClock = true;
        appearance.wallpaper = wallpaper_path;
        autoLock = false;
        timeout = 0;
      };

      # Windows
      kwin = {
        effects = {
          blur.enable = true;
          cube.enable = false;
          desktopSwitching.animation = "slide";
          dimAdminMode.enable = false;
          dimInactive.enable = false;
          fallApart.enable = false;
          fps.enable = false;
          minimization.animation = "off";
          shakeCursor.enable = false;
          slideBack.enable = false;
          snapHelper.enable = true;
          translucency.enable = true;
          windowOpenClose.animation = "scale";
          wobblyWindows.enable = true;
        };

        # Nightlight
        nightLight = mkIf cfg.nightLight {
          enable = true;
          location.latitude = "40.71";
          location.longitude = "-74.01";
          mode = "location";
          temperature.night = 4000;
        };

        virtualDesktops = {
          number = 4;
          rows = 1;
        };
      };

      panels = [
        {
          alignment = "left";
          height = 30;
          lengthMode = "fit";
          location = "top";
          opacity = "translucent";
          widgets = [{
            name = "org.dhruv8sh.kara";
            config = {
              general = {
                animationDuration = 0;
                highlightType = 1;
                spacing = 3;
                type = 1;
              };
              type1 = {
                fixedLen = 3;
                labelSource = 0;
              };
            };
          }];
        }
        {
          alignment = "center";
          height = 57;
          lengthMode = "fit";
          location = "top";
          opacity = "translucent";
          hiding = "dodgewindows";
          widgets = [{
            name = "org.kde.plasma.icontasks";
            config = {
              iconsOnly = true;
              appearance = {
                showTooltips = false;
                highlightWindows = false;
                indicateAudioStreams = true;
                # rows.maximum = 1;
                iconSpacing = "small";
              };
              # The apps pinnned to the dock
              launchers = [
                "preferred://browser" # browser
                "applications:org.kde.dolphin.desktop" # file manager
              ] ++ lib.optionals config.features.cli.alacritty.enable
                [ "applications:Alacritty.desktop" ]
                ++ lib.optionals config.features.school.obsidian.enable
                [ "applications:obsidian.desktop" ]
                ++ lib.optionals config.features.games.discord.enable
                [ "applications:discord.desktop" ]
                ++ lib.optionals config.features.games.minecraft.enable
                [ "applications:org.prismlauncher.PrismLauncher.desktop" ];
            };
          }];
        }
        {
          alignment = "right";
          height = 30;
          lengthMode = "fit";
          location = "top";
          opacity = "translucent";
          widgets = [
            {
              systemTray = {
                icons.scaleToFit = true;
                items = {
                  showAll = false;
                  shown = [
                    "org.kde.plasma.battery"
                    "org.kde.plasma.networkmanagement"
                    "org.kde.plasma.volume"
                  ];
                  hidden = [
                    "org.kde.plasma.brightness"
                    "org.kde.plasma.clipboard"
                    "org.kde.plasma.devicenotifier"
                    "org.kde.plasma.mediacontroller"
                    "plasmashell_microphone"
                    "xdg-desktop-portal-kde"
                    "zoom"
                  ];
                  configs = {
                    "org.kde.plasma.notifications".config = {
                      Shortcuts = { global = "Meta+N"; };
                    };
                    battery.showPercentage = true;
                  };
                };
              };
            }
            {
              name = "org.kde.plasma.digitalclock";
              config = {
                Appearance = {
                  showDate = false;
                  autoFontAndSize = false;
                  fontSize = 11;
                  fontStyleName = "Regular";
                  fontWeight = 400;
                  use24hFormat = "12h";
                };
              };
            }
          ];
        }
      ];

      # Power settings
      powerdevil = {
        # Plugged in
        AC = {
          autoSuspend = {
            action = "sleep";
            idleTimeout = 900; # 15 minutes
          };

          whenSleepingEnter = "standby";
          whenLaptopLidClosed = "sleep";
          inhibitLidActionWhenExternalMonitorConnected = true;

          turnOffDisplay = {
            idleTimeout = 300; # 5 minutes
            idleTimeoutWhenLocked = 60; # 1 minute
          };

          dimDisplay = {
            enable = true;
            idleTimeout = 180; # 3 minutes
          };

          powerProfile = "performance";
          powerButtonAction = "shutDown";
        };

        # On battery
        battery = {
          autoSuspend = {
            action = "sleep";
            idleTimeout = 480; # 8 minutes
          };

          whenSleepingEnter = "standby";
          whenLaptopLidClosed = "sleep";
          inhibitLidActionWhenExternalMonitorConnected = true;

          turnOffDisplay = {
            idleTimeout = 240; # 4 minutes
            idleTimeoutWhenLocked = 60; # 1 minute
          };

          dimDisplay = {
            enable = true;
            idleTimeout = 120; # 2 minutes
          };

          powerProfile = "balanced";
          powerButtonAction = "shutDown";
        };

        # Low battery
        lowBattery = {
          autoSuspend = {
            action = "sleep";
            idleTimeout = 120; # 8 minutes
          };

          whenSleepingEnter = "standby";
          whenLaptopLidClosed = "sleep";
          inhibitLidActionWhenExternalMonitorConnected = true;

          turnOffDisplay = {
            idleTimeout = 60; # 1 minute
            idleTimeoutWhenLocked = 60; # 1 minute
          };

          dimDisplay = {
            enable = true;
            idleTimeout = 30; # 30 seconds
          };

          powerProfile = "powerSaving";
          powerButtonAction = "shutDown";
        };

        # General
        general.pausePlayersOnSuspend = true;

        # Battery levels
        batteryLevels = {
          lowLevel = 15;
          criticalLevel = 5;
          criticalAction = "nothing";
        };

      };

      session = {
        general.askForConfirmationOnLogout = false;
        sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
      };

      shortcuts = {
        ksmserver = {
          "Lock Session" = [ "Screensaver" "Meta+L" ];
          "LogOut" = [ "Meta+Shift+L" ];
        };

        kwin = {
          "KrohnkiteMonocleLayout" = [ ];
          "Switch to Desktop 1" = "Meta+1";
          "Switch to Desktop 2" = "Meta+2";
          "Switch to Desktop 3" = "Meta+3";
          "Switch to Desktop 4" = "Meta+4";
          "Window Close" = "Meta+Q";
          "Window Fullscreen" = "F11"; # No menu bar
          "Window Maximize" = "Meta+Up"; # Still has menu bar
          "Show Desktop" = "Meta+M";
        };

        plasmashell = { "show-on-mouse-pos" = ""; };

        "services/org.kde.dolphin.desktop"."_launch" = "Meta+Shift+F";

        # Disable krunner shortcut
        "services/org.kde.krunner.desktop"."_launch" =
          (if cfg.krunner then [ "Alt+Space" ] else [ "Alt+F2" ]);
      };

      spectacle = {
        shortcuts = {
          captureEntireDesktop = "";
          captureRectangularRegion = "";
          launch = "";
          recordRegion = "Meta+Shift+R";
          recordScreen = "Meta+Ctrl+R";
          recordWindow = "";
        };
      };

      window-rules = [{
        apply = {
          noborder = {
            value = true;
            apply = "initially";
          };
        };
        description = "Hide titlebar by default";
        match = {
          window-class = {
            value = ".*";
            type = "regex";
          };
        };
      }];

      workspace = {
        enableMiddleClickPaste = false;
        clickItemTo = "select";
        colorScheme = "CatppuccinMochaBlue";
        cursor.theme = "Yaru";
        splashScreen.engine = "none";
        splashScreen.theme = "none";
        tooltipDelay = 1;
        wallpaper = wallpaper_path;
      };

      configFile = {
        baloofilerc."Basic Settings"."Indexing-Enabled" = false;
        gwenviewrc.ThumbnailView.AutoplayVideos = true;
        kdeglobals = {
          General = { BrowserApplication = "firefox"; };
          Icons = { Theme = "beauty-line"; };
          KDE = { AnimationDurationFactor = 0.3; };
        };
        klaunchrc.FeedbackStyle.BusyCursor = false;
        klipperrc.General.MaxClipItems = 1000;
        kwinrc = {
          MouseBindings.CommandAllKey =
            "Meta"; # Hold ALT to resize/move windows
          Effect-overview.BorderActivate = 9;
          Plugins = {
            krohnkiteEnabled = true;
            screenedgeEnabled = false;
          };
          "Round-Corners" = {
            ActiveOutlineAlpha = 0;
            ActiveOutlineUseCustom = false;
            ActiveOutlineUsePalette = true;
            DisableOutlineTile = false;
            DisableRoundTile = false;
            InactiveCornerRadius = 8;
            InactiveOutlineAlpha = 0;
            InactiveSecondOutlineThickness = 0;
            OutlineThickness = 0;
            SecondOutlineThickness = 0;
            Size = 8;
          };
          # "Script-krohnkite" = {
          #   floatingClass =
          #     "brave-nngceckbapebfimnlniiiahkandclblb-Default,org.kde.kcalc,org.freedesktop.impl.portal.desktop.kde";
          #   screenGapBetween = 6;
          #   screenGapBottom = 6;
          #   screenGapLeft = 6;
          #   screenGapRight = 6;
          #   screenGapTop = 6;
          # };
          Windows = {
            DelayFocusInterval = 0;
            FocusPolicy = "FocusFollowsMouse";
          };
        };
        plasmanotifyrc = {
          DoNotDisturb = {
            WhenFullscreen = false;
            WhenScreenSharing = false;
            WhenScreensMirrored = false;
          };
          Notifications = {
            PopupPosition = "TopRight";
            PopupTimeout = 7000;
          };
        };
        plasmarc.OSD.Enabled = false;
        spectaclerc = {
          Annotations = {
            annotationToolType = 8;
            rectangleStrokeColor = "255,0,0";
          };
          General = {
            launchAction = "DoNotTakeScreenshot";
            showCaptureInstructions = false;
            useReleaseToCapture = true;
          };
          ImageSave.imageCompressionQuality = 100;
        };
      };
      dataFile = {
        "dolphin/view_properties/global/.directory"."Dolphin"."ViewMode" = 1;
        "dolphin/view_properties/global/.directory"."Settings"."HiddenFilesShown" =
          true;
      };
    };

  };
}

