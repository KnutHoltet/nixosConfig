{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.system.boot.efi;
in {
  options.system.boot.efi = with types; {
    enable = mkBoolOpt true "Whether or not to enable efi booting.";
  };

  config = mkIf cfg.enable {
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.configurationLimit = 5;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot/efi";
    boot.loader.timeout = 2;
    boot.initrd.enable = true;
    boot.initrd.systemd.enable = true;
    boot.kernelParams = [ "quiet" "fbcon=nodefer" "vt.global_cursor_default=0" "kernel.modules_disabled=1" "lsm=landlock,lockdown,yama,integrity,apparmor,bpf" "usbcore.autosuspend=-1" "video4linux" "acpi_rev_override=5" ];
    boot.plymouth = {
    enable = true;
    # logo = pkgs.fetchurl {
    #         url = "https://pluspng.com/img-png/black-lagoon-png-revy-1-png-1594-1080-anime-boysdjblack-lagoon-1594.png";
    #         sha256 = "e0CZmXTVIJv6BDXXYksTsncl9t/QGkYC/BavNy4fcnQ=";
    #       };
    font = "${pkgs.jetbrains-mono}/share/fonts/truetype/JetBrainsMono-Regular.ttf";
    themePackages = [ pkgs.catppuccin-plymouth ];
    theme = "catppuccin-macchiato";
  };


    # https://github.com/NixOS/nixpkgs/blob/c32c39d6f3b1fe6514598fa40ad2cf9ce22c3fb7/nixos/modules/system/boot/loader/systemd-boot/systemd-boot.nix#L66
    boot.loader.systemd-boot.editor = false;
  };
}
