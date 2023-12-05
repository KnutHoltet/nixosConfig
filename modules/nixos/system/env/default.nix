{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.system.env;
in {
  options.system.env = with types;
    mkOption {
      type = attrsOf (oneOf [str path (listOf (either str path))]);
      apply = mapAttrs (_n: v:
        if isList v
        then concatMapStringsSep ":" toString v
        else (toString v));
      default = {};
      description = "A set of environment variables to set.";
    };

  config = {
    environment = {
      sessionVariables = {
        XDG_CACHE_HOME = "$HOME/.cache";
        XDG_CONFIG_HOME = "$HOME/.config";
        XDG_DATA_HOME = "$HOME/.local/share";
        XDG_BIN_HOME = "$HOME/.local/bin";
        # To prevent firefox from creating ~/Desktop.
        XDG_DESKTOP_DIR = "$HOME";

        NIXOS_OZONE_WL = "1";
        WLR_NO_HARDWARE_CURSORS = "1";
      };

      variables = {
        # Make some programs "XDG" compliant.
        LESSHISTFILE = "$XDG_CACHE_HOME/less.history";
        WGETRC = "$XDG_CONFIG_HOME/wgetrc";

        # Enable theme
        GTK_THEME = "Catppuccin-Macchiato-Standard-Teal-Dark";
	XCURSOR_THEME = "Catppuccin-Macchiato-Teal";
	XCURSOR_SIZE = "24";
	
	# ENV Variables
	SPOTIFY_PATH = "${pkgs.spotify}/";
	JDK_PATH = "${pkgs.jdk11}/";
	NODEJS_PATH = "${pkgs.nodePackages_latest.nodejs}/";

	# Clipboard
	CI = "1";
	CLIPBOARD_NOAUDIO = "1";
	CLIPBOARD_SILENT = "1";
	# Additional clipboard options
	# CLIPBOARD_EDITOR = "hx";	
	# CLIPBOARD_NOGUI = "1";
	# CLIPBOARD_NOPROGRESS = "1";
	# CLIPBOARD_NOREMOTE = "1";
      };

      extraInit =
        concatStringsSep "\n"
        (mapAttrsToList (n: v: ''export ${n}="${v}"'') cfg);
    };

  console = {
    earlySetup = true;
    colors = [
      "24273a"
      "ed8796"
      "a6da95"
      "eed49f"
      "8aadf4"
      "f5bde6"
      "8bd5ca"
      "cad3f5"
      "5b6078"
      "ed8796"
      "a6da95"
      "eed49f"
      "8aadf4"
      "f5bde6"
      "8bd5ca"
      "a5adcb"
    ];
  };

  };

}
