{
  concatText,
  librespot,
  portableService,
  snapcast,
}:
portableService {
  pname = "snapcast";
  inherit (snapcast) version;
  units = [
    (concatText "snapcast-server.service" ["${snapcast.src}/extras/package/rpm/snapserver.service"])
    (concatText "snapcast-client.service" ["${snapcast.src}/extras/package/rpm/snapclient.service"])
  ];
  symlinks = [
    {
      object = "${snapcast}/bin/snapserver";
      symlink = "/usr/bin/snapserver";
    }
    {
      object = "${snapcast}/bin/snapclient";
      symlink = "/usr/bin/snapclient";
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
