{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.system.xkb;
in {
  options.system.xkb = with types; {
    enable = mkBoolOpt true "Whether or not to configure xkb.";
  };

  config = mkIf cfg.enable {
    console.useXkbConfig = true;
    services.xserver = {
      layout = "no", "us";
      xkbOptions = "grp:alt_shift_toggle";
    };
  };
}
