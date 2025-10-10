{ fetchFromBitbucket, stdenv, lib }:

stdenv.mkDerivation rec {
  pname = "yet-another-monochrome-icon-set";
  version = "1.1.1";

  src = fetchFromBitbucket {
    owner = "dirn-typo";
    repo = "yet-another-monochrome-icon-set";
    rev = "014d2f235546c7a2fd9bb859ab5469babd19c248";
    sha256 = "sha256-/P69zeMVgJyW2tUpE1ZPE7jzEY/jvn4Mrm2cSAkn+GE=";
  };

  installPhase = ''
    ICON_DIR=$out/share/icons/$pname
    mkdir -p $ICON_DIR
    cp -r * $ICON_DIR
  '';

  meta = with lib; {
    description = "Yet Another Monochrome Icon Set for KDE";
    homepage =
      "https://bitbucket.org/dirn-typo/yet-another-monochrome-icon-set";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}

