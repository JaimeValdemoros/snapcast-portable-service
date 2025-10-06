{
  concatText,
  librespot,
  portableService,
  snapcast,
}:
portableService {
  pname = "snapserver";
  inherit (snapcast) version;
  units = [
    (concatText "snapserver.service" ["${snapcast.src}/extras/package/rpm/snapserver.service"])
  ];
  symlinks = [
    {
      object = "${snapcast}/bin/snapserver";
      symlink = "/usr/bin/snapserver";
    }
    {
      object = "${snapcast}/etc/snapserver.conf";
      symlink = "/etc/snapserver.conf";
    }
    {
      object = "${librespot}/bin/librespot";
      symlink = "/bin/librespot";
    }
  ];
}
