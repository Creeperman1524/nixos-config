# KDE user features

{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.features.desktop.kde;
  wallpaper_path = "/home/ant/Pictures/sunset.jpg";
in {
  options.features.desktop.kde.enable = mkEnableOption "KDE Plasma config";

  config = mkIf cfg.enable {

    programs.kitty.enable = true;

    # Thanks to https://github.com/AlexNabokikh/nix-config/
    home.packages = with pkgs; [
      firefox
      alacritty
      (catppuccin-kde.override {
        flavour = [ "mocha" ];
        accents = [ "blue" ];
      })
      kde-rounded-corners
      kdePackages.kcalc
      # kdePackages.krohnkite # tiling window manager
      kdotool
      tela-circle-icon-theme
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
          family = "Roboto";
          pointSize = 11;
        };
        menu = {
          family = "Roboto";
          pointSize = 11;
        };
        small = {
          family = "Roboto";
          pointSize = 8;
        };
        toolbar = {
          family = "Roboto";
          pointSize = 11;
        };
        windowTitle = {
          family = "Roboto";
          pointSize = 11;
        };
      };

      hotkeys.commands = {
        launch-alacritty = {
          name = "Launch Alacritty";
          key = "Meta+Shift+Return";
          command = "alacritty";
        };
        launch-brave = {
          name = "Launch Brave";
          key = "Meta+Shift+B";
          command = "firefox";
        };
        launch-ocr = {
          name = "Launch OCR";
          key = "Alt+@";
          command = "ocr";
        };
        launch-telegram = {
          name = "Launch Telegram";
          key = "Meta+Shift+T";
          command = "Telegram";
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
          key = "Meta+Shift+S";
          command = "spectacle --region --nonotify";
        };
        screenshot-screen = {
          name = "Capture the entire desktop";
          key = "Meta+Ctrl+S";
          command = "spectacle --fullscreen --nonotify";
        };
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
      krunner = {
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
        nightLight = {
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
          height = 30;
          lengthMode = "fit";
          location = "top";
          opacity = "translucent";
          widgets = [{
            name = "org.kde.plasma.digitalclock";
            config = {
              Appearance = {
                autoFontAndSize = false;
                customDateFormat = "ddd MMM d";
                dateDisplayFormat = "BesideTime";
                dateFormat = "custom";
                fontSize = 11;
                fontStyleName = "Regular";
                fontWeight = 400;
                use24hFormat = 0;
              };
            };
          }];
        }
        {
          alignment = "right";
          height = 30;
          lengthMode = "fit";
          location = "top";
          opacity = "translucent";
          widgets = [{
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
                };
              };
            };
          }];
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
          "Lock Session" = [ "Screensaver" "Ctrl+Alt+L" ];
          "LogOut" = [ "Ctrl+Alt+Q" ];
        };

        "KDE Keyboard Layout Switcher" = {
          "Switch to Next Keyboard Layout" = "Meta+Space";
        };

        kwin = {
          "KrohnkiteMonocleLayout" = [ ];
          "Switch to Desktop 1" = "Meta+1";
          "Switch to Desktop 2" = "Meta+2";
          "Switch to Desktop 3" = "Meta+3";
          "Switch to Desktop 4" = "Meta+4";
          "Switch to Desktop 5" = "Meta+5";
          "Switch to Desktop 6" = "Meta+6";
          "Switch to Desktop 7" = "Meta+7";
          "Window Close" = "Meta+Q";
          "Window Fullscreen" = "Meta+M";
          "Window Move Center" = "Ctrl+Alt+C";
        };

        plasmashell = { "show-on-mouse-pos" = ""; };

        "services/org.kde.dolphin.desktop"."_launch" = "Meta+Shift+F";
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

      window-rules = [
        {
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
        }
        {
          apply = {
            desktops = "Desktop_1";
            desktopsrule = "3";
          };
          description = "Assign Brave to Desktop 1";
          match = {
            window-class = {
              value = "brave-browser";
              type = "substring";
            };
            window-types = [ "normal" ];
          };
        }
        {
          apply = {
            desktops = "Desktop_2";
            desktopsrule = "3";
          };
          description = "Assign Alacritty to Desktop 2";
          match = {
            window-class = {
              value = "Alacritty";
              type = "substring";
            };
            window-types = [ "normal" ];
          };
        }
        {
          apply = {
            desktops = "Desktop_3";
            desktopsrule = "3";
          };
          description = "Assign Telegram to Desktop 3";
          match = {
            window-class = {
              value = "org.telegram.desktop";
              type = "substring";
            };
            window-types = [ "normal" ];
          };
        }
        {
          apply = {
            desktops = "Desktop_4";
            desktopsrule = "3";
          };
          description = "Assign OBS to Desktop 4";
          match = {
            window-class = {
              value = "com.obsproject.Studio";
              type = "substring";
            };
            window-types = [ "normal" ];
          };
        }
        {
          apply = {
            desktops = "Desktop_4";
            desktopsrule = "3";
            fsplevel = "4";
            fsplevelrule = "2";
            minimizerule = "2";
          };
          description = "Assign Steam to Desktop 4";
          match = {
            window-class = {
              value = "steam";
              type = "exact";
              match-whole = false;
            };
            window-types = [ "normal" ];
          };
        }
        {
          apply = {
            desktops = "Desktop_5";
            desktopsrule = "3";
            fsplevel = "4";
            fsplevelrule = "2";
          };
          description = "Assign Steam Games to Desktop 5";
          match = {
            window-class = {
              value = "steam_app_";
              type = "substring";
              match-whole = false;
            };
          };
        }
        {
          apply = {
            desktops = "Desktop_5";
            desktopsrule = "3";
            fsplevel = "4";
            fsplevelrule = "2";
            minimizerule = "2";
          };
          description = "Assign Zoom to Desktop 5";
          match = {
            window-class = {
              value = "zoom";
              type = "substring";
            };
            window-types = [ "normal" ];
          };
        }
      ];

      workspace = {
        enableMiddleClickPaste = false;
        clickItemTo = "select";
        colorScheme = "CatppuccinMochaBlue";
        cursor.theme = "Yaru";
        splashScreen.engine = "none";
        splashScreen.theme = "Breeze";
        tooltipDelay = 1;
        wallpaper = wallpaper_path;
      };

      configFile = {
        baloofilerc."Basic Settings"."Indexing-Enabled" = false;
        gwenviewrc.ThumbnailView.AutoplayVideos = true;
        kdeglobals = {
          General = { BrowserApplication = "firefox"; };
          Icons = { Theme = "Tela-circle-dark"; };
          KDE = { AnimationDurationFactor = 0.3; };
        };
        klaunchrc.FeedbackStyle.BusyCursor = false;
        klipperrc.General.MaxClipItems = 1000;
        kwinrc = {
          Effect-overview.BorderActivate = 9;
          Plugins = {
            krohnkiteEnabled = true;
            screenedgeEnabled = false;
          };
          "Round-Corners" = {
            ActiveOutlineAlpha = 255;
            ActiveOutlineUseCustom = false;
            ActiveOutlineUsePalette = true;
            DisableOutlineTile = false;
            DisableRoundTile = false;
            InactiveCornerRadius = 8;
            InactiveOutlineAlpha = 0;
            InactiveSecondOutlineThickness = 0;
            OutlineThickness = 1;
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

