{
  concatText,
  portableService,
  snapcast,
}:
portableService {
  pname = "snapclient";
  inherit (snapcast) version;
  units = [
    (concatText "snapclient.service" [./snapclient.service])
  ];
  symlinks = [
    {
      object = "${snapcast}/bin/snapclient";
      symlink = "/bin/snapclient";
    }
  ];
}
