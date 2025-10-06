{
  concatText,
  librespot,
  portableService,
  snapcast,
  writeText,
}:
portableService {
  pname = "snapserver";
  inherit (snapcast) version;
  units = [
    (concatText "snapserver.service" ["${snapcast.src}/extras/package/rpm/snapserver.service"])
    (writeText "snapserver-client.service" (
      builtins.readFile "${snapcast.src}/extras/package/rpm/snapclient.service"
      + ''
        [Service]
        Environment=SNAPCLIENT_OPTS="tcp://127.0.0.1:1704"
      ''
    ))
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
      object = "${snapcast}/bin/snapclient";
      symlink = "/usr/bin/snapclient";
    }
    {
      object = "${librespot}/bin/librespot";
      symlink = "/bin/librespot";
    }
  ];
}
