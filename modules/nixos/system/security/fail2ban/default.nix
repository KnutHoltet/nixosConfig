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
    fail2ban.enable = mkBoolOpt true "Enable fail2ban";
  };

  config =
    mkIf cfg.enable {
     cfg.fail2ban.enable = true;
    };
}
