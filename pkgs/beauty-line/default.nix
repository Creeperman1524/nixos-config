{ fetchFromGitLab, stdenv, lib }:

stdenv.mkDerivation rec {
  pname = "beauty-line";
  version = "2.4";

  src = fetchFromGitLab {
    owner = "garuda-linux/themes-and-settings/artwork";
    domain = "gitlab.com";
    repo = "beautyline";
    rev = "0df6f5df71c19496f9a873f8a52fbb5e84e95b12";
    sha256 = "sha256-SsYW4H1qam7kQJ3E4/vHJJOv2E4Pdk3itGncWa6YTqw=";
  };

  installPhase = ''
    ICON_DIR=$out/share/icons/$pname
    mkdir -p $ICON_DIR
    cp -r * $ICON_DIR
  '';

  meta = with lib; {
    description = "BeautyLine";
    homepage =
      "https://gitlab.com/garuda-linux/themes-and-settings/artwork/beautyline/-/tree/master";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}

