{
  concatText,
  portableService,
  replaceVars,
  snapcast,
}:
portableService {
  pname = "snapclient";
  inherit (snapcast) version;
  units = [
    (replaceVars ./snapclient.service {
      STATE_DIR = "snapclient";
      DEFAULT_SNAPCLIENT_OPTS = "";
    })
  ];
  # required to mount StateDirectory
  emptyDirs = ["/var/lib/snapclient"];
  # Required for alsalib to access group ids
  emptyFiles = ["/etc/group"];
  symlinks = [
    {
      object = "${snapcast}/bin/snapclient";
      symlink = "/bin/snapclient";
    }
  ];
}
