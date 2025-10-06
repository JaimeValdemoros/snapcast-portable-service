{
  concatText,
  portableService,
  snapcast,
}:
portableService {
  pname = "snapclient";
  inherit (snapcast) version;
  units = [
    (concatText "snapclient.service" ["${snapcast.src}/extras/package/rpm/snapclient.service"])
  ];
  symlinks = [
    {
      object = "${snapcast}/bin/snapclient";
      symlink = "/usr/bin/snapclient";
    }
  ];
}
