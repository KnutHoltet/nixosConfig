{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.suites.common;
in {
  options.suites.common = with types; {
    enable = mkBoolOpt true "Enable the common suite";
  };

  config = mkIf cfg.enable {
    system.nix.enable = true;
    system.security.doas.enable = true;

    hardware.audio.enable = true;
    hardware.networking.enable = true;

    # hardware.bluetooth.enable = true;
    # hardware.bluetooth.settings = {
    #   General = {
    #     FastConnectable = true;
    #     JustWorksRepairing = "always";
    #     Privacy = "device";
    #   };
    #   Policy = {
    #     AutoEnable = true;
    #   };
    # };

    services.ssh.enable = true;
    programs.dconf.enable = true;

    environment.systemPackages = [pkgs.bluetuith pkgs.custom.sys];

    system = {
      fonts.enable = true;
      locale.enable = true;
      time.enable = true;
      xkb.enable = true;
    };
  };
}