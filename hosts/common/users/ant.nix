# User information for all hosts

{ config, pkgs, inputs, ... }: {
  users.groups.ant = { };

  # Defines the 'ant' user
  users.users.ant = {
    # openssl passwd -6 for SHA-512
    initialHashedPassword =
      "$6$tDklCr18CCAy28QN$sLUCGltKsgsHidsXFmjY3XEjijcF2BzgRcgQ8NzNC1qB4FQPrU7jzSx9xKSLaSi/21lw8JXXlr6I6fsnCN53m0";
    isNormalUser = true;
    description = "ant";
    extraGroups = [
      "wheel" # sudo
      "networkmanager"
      "libvirtd"
      "flatpak"
      "audio"
      "video"
      "plugdev"
      "input"
      "kvm"
      "qemu-libvirtd"
    ];

    # Allows ssh from laptop
    openssh.authorizedKeys.keys = [
	   # laptop
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC5feQTK1K5wO7Tm90Lip6aQ3Ay0oEzQ2dGtS7GCkmAuVBFqz+SkD+mEhYSRtITwZ7s0EujgMgm5STdZ1l9VqzoQGmOalpjWIrCCy7d3ag3QSdob1P/lxokanZVE3/nH9XrJKUx97azv3CAgUzWA8ypo4hhJ4sQIVGQEk/BqDxLcK+Y1KzfvRQq6Wemevq71ZPX5QRuCXUdMWQMQ4gKcqNBMCnzawaMV25TIFT97Hr1zRwXkwquYpg4adVhHnsOt2Svfi0hWmf1DnM1qzwbWe8XhpEZlqmH3ne9mag3xPnxx/rONwdW1D5/2PB21ZAwmyS8U5kVtxTJu4f6hlz+oDp/5rLJBh34h4uKvHavTX5I/Nl+btBHmntM+JTds/w5dEGciqUAgBZHOn3e+4p3sZx0/AscS1FCgjPhocnBYK/mML8omhxfDbajcyJu0g+jcrB0lZ8DCY/nrISliquxS5B1NjSE9bv+5z+Kgo+8QfxWzD9JsKsGgpT9ugTqMcwB+/U= ant@laptop"
	  # desktop
	  "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCSB/zMs4yqk5PK8qMKFW6ZwaHSGHAWXEGF8KKJxTcE/SUc+wutfjPsALERUNdiLdZWHCnV0M7cH5wS6R+G1zdD+KI1SgEI6Kv3WeJoEJ6vYDBV2njToSp7Cu99MIVWB45mr/swopcAW7XtSsf17BWb+OD9rVFMgOJ3+VS3qf7zDx0Mcofz3HEHdblXpXwQEP40ezjcbIXNG9geih8B0Jx7D4M2K5fbBzlespOXn2pkmij6w33AgJDALNn44QyXvxOHurcUym5f/ujQXTOtd2gKo+PnPYOwqVTZfhbr22DOwVPd82kqEpKfqa3Fzh5+3upzlZ2E7KuZj//L5ArkZ7OR3Ala2me/6VlqfW06JTAeUGwHVP74itDDLrkZenBfK7cFxwZ0AzvH3WdXwYrU/eLN7ZJCFQDM5JsqmotLupXRU9T8dJJDNBIxO8UkI7PK75WT02SUKvC0Et7u6MCiGUSE4zQaujwXg5aBsS91Uz+3EyBbH6hjlXK/1L07Gaf0o9U= ant@desktop"
    ];

    # Adds all the home manager packages 
    packages = [ inputs.home-manager.packages.${pkgs.system}.default ];
  };

  home-manager.users.ant = {
    imports = [
      ../../../shared/${config.networking.hostName}.nix
      ../../../home/ant/${config.networking.hostName}.nix
    ];
  };
}

