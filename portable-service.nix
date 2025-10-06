{
  concatText,
  portableService,
  snapcast,
}:
portableService {
  pname = "snapcast";
  inherit (snapcast) version;
  units = [
  ];
}
