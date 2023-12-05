{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.services.openssh;
in {
  options.services.openssh = with types; {
    enable = mkBoolOpt true "OpenSSH server";
    permitRootLogin = mkOption {
     type = types.str; 
     default = "prohibit-password";
     description = "Permit root login option for OpenSSH.";
    };
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      ports = [22];
      permitRootLogin = "prohibit-password";
    };

    users.users = let 
        publicKey = ""; # Enter your ssh public key
    in
    {
      root.openssh.authorizedKeys.keys = [
        publicKey
      ];
      ${config.user.name}.openssh.authorizedKeys.keys = [
        publicKey
      ];
    };

    home.file.".ssh/config".text = ''
      identityfile ~/.ssh/key 
    '';
  };
}
