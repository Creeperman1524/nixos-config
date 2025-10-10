{ pkgs, ... }: {
  # Define your custom packages here
  #  my-package = pkgs.callPackage ./my-package {};
  monochrome-icons = pkgs.callPackage ./monochrome { };
  beauty-line = pkgs.callPackage ./beauty-line { };
}

