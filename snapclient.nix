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
