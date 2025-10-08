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
    (concatText "snapserver.service" [./snapserver.service])
  ];
  # required to mount StateDirectory
  emptyDirs = ["/var/lib/snapserver"];
  symlinks = [
    {
      object = "${snapcast}/bin/snapserver";
      symlink = "/bin/snapserver";
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
