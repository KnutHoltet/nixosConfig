{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.hardware.networking;
in {
  options.hardware.networking = with types; {
    enable = mkBoolOpt true "Enable pipewire";
  };

  config = mkIf cfg.enable {
    networking.networkmanager.enable = true;
    netowrking.hostname = "knuth";
    dns = "none";

    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = false;
    services.blueman.enable = true;

    networking.firewall.enable = true;
    # networking.firewall.allowedTCPPorts = [ 3000 ];
    # networking.firewall.allowedUDPPorts = [ 3000 ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    networking = {
     nameservers = ["127.0.0.1" "::1"];
     dhcpcd.extraConfig = "nohook resolv.conf";
    };
  };
}
