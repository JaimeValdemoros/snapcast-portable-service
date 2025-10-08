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
    (concatText "snapserver.socket" [./snapserver.socket])
  ];
  # required to mount StateDirectory
  emptyDirs = ["/var/lib/snapserver" "/run/snapserver"];
  symlinks = [
    {
      object = "${snapcast}/bin/snapserver";
      symlink = "/bin/snapserver";
    }
    {
      object = ./snapserver.conf;
      symlink = "/etc/snapserver.conf";
    }
    {
      object = "${librespot}/bin/librespot";
      symlink = "/bin/librespot";
    }
  ];
}
