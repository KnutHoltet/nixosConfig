{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.services.fail2ban;
in {
  options.services = with types; {
    enable = mkBoolOpt true "Enable fail2ban";
  };

  config =
    mkIf cfg.enable {
     services.fail2ban.enable = true;
    };
}
