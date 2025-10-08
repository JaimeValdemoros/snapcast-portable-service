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
  emptyDirs = [
    # required to mount StateDirectory
    "/var/lib/snapserver"
    "/run/snapserver"
    # https://stackoverflow.com/questions/30646943/how-to-avahi-browse-from-a-docker-container
    "/run/avahi-daemon"
  ];
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
