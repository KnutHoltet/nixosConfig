{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.services;
in {
  options.services = with types; {
    enable = mkBoolOpt true "Enable fail2ban";
  };

  config =
    mkIf cfg.enable {
     fail2ban.enable = true;
    };
}
