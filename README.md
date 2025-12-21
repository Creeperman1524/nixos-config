# nixos-config

This is a repo to hold my [NixOs](https://nixos.org/) configuration that I am currently testing out

> [!note]
> I do intend on switching to NixOs as my daily driver, but who knows when that will happen!

Definitions:

- "_host_" - a physical machine that is running nixos
- "_user_" - a user account of the system, which can be shared between hosts
- "_package_" - a program that can be used on nixos like any other distro
- "_feature_" - a predefined set of settings for a package (which can have other exposed settings) (aka. a sort of wrapper for a package)

## File Structure

> todo :(
> Based on [this youtube playlist](https://www.youtube.com/playlist?list=PLCQqUlIAw2cCuc3gRV9jIBGHeekVyBUnC), but I also started doing my own thing

## Building/Using

Currently, I have been using the guide found [here](https://devctrl.blog/posts/step-by-step-guide-installing-nix-os-on-virtual-box/), which is a complete
guide to installing NixOs on VirtualBox. Intead of using librephoenix's NixOs, I simply just clone my repo.

> [!caution]
> Be **sure** to copy the `hardware-configuration.nix` that is generated on your system into the repo, by whatever means necessary. Otherwise, NixOs will not boot properly and you will have to redo it!

> [!warning]
> It also seems that VirtualBox struggles running Hyprland, so I will have to configure/test that out when I actually install NixOs on bare metal

Running this command will then build the system. Be sure to reboot afterwards to make sure all changes are applied!

```bash
sudo nixos-rebuild switch --flake /home/<USER>/nix#<HOST>
```

- Where `<USER>` is the user setup at install
- and `<HOST>` is either `da-desktop` or `da-laptop` (found in `hosts/`, not including `hosts/common/`)

I might make a better installation script later... who knows!

### Settings

- Common home-manager 'user' settings can be changed in `hosts/common/users/<USER>.nix`
- Per-user per-host 'user' settings can be changed in `home/<USER>/<HOST>.nix`
  - These settings are defined in `home/features/*`, and are made completely by metal
  - This affects 'user-level' settings, like what features are added and settings to have
- 'Host' settings can be changed in `shared/<HOST>.nix`
  - This affects 'system-level' settings, like what display manager to use (defined in `shared/definitions.nix`)
