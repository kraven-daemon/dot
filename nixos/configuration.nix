# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  # bash script to let dbus know about important env variables and
  # propagate them to relevent services run at the end of sway config
  # see
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  # note: this is pretty much the same as  /etc/sway/config.d/nixos.conf but also restarts  
  # some user services to make sure they have the correct environment variables
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
  dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
  systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
  systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      '';
  };

  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
  configure-gtk = pkgs.writeTextFile {
      name = "configure-gtk";
      destination = "/bin/configure-gtk";
      executable = true;
      text = let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
      in ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        gnome_schema=org.gnome.desktop.interface
        gsettings set $gnome_schema gtk-theme 'Dracula'
        '';
};
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";



  networking = {
  	hostName = "turtle";
  	#wireless.enable = true;
	#proxy.default = "http://user:password@proxy:port/";
	#proxy.noProxy = "127.0.0.1,localhost,internal.domain";
	networkmanager.enable = true;
	firewall = {
	  enable = true;
	  allowedTCPPorts = [ 80 ];
	};
  };

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";


  # To enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  # Xserver configuration
  services = {
	xserver = {
		enable = true;
		autorun = false;
		displayManager.startx.enable = true;
		windowManager.herbstluftwm.enable = true;     
		layout = "us";
		xkbVariant = "";
		libinput.enable = true;
	};
	# Enable CUPS to print documents.
	printing.enable = false;
	pipewire = {
	    enable = true;
	    alsa.enable = true;
	    alsa.support32Bit = true;
	    pulse.enable = true;
	    # If you want to use JACK applications, uncomment this
	    #jack.enable = true;

	    # use the example session manager (no others are packaged yet so this is enabled by default,
	    # no need to redefine it in your config for now)
	    #media-session.enable = true;
	  };
	# Enable the OpenSSH daemon.
	# openssh.enable = true;

	# xdg-desktop-portal works by exposing a series of D-Bus interfaces
	# known as portals under a well-known name
	# (org.freedesktop.portal.Desktop) and object path
	# (/org/freedesktop/portal/desktop).
	# The portal interfaces include APIs for file access, opening URIs,
	# printing and others.
	dbus.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kraven = {
    isNormalUser = true;
    description = "kraven";
    extraGroups = [ "networkmanager" "wheel" "adbusers" ];
    packages = with pkgs; [
	firefox
	herbstluftwm
	rofi
	polybar
	alacritty
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    xorg.xmodmap
    neovim
    wget
    binutils
    fd
    exa
    sd
    ripgrep
    jq
    git
    alacritty
    sway
    dbus-sway-environment
    configure-gtk
    wayland
    xdg-utils
    glib
    dracula-theme
    gnome3.adwaita-icon-theme
    swaylock
    swayidle
    grim
    slurp
    wl-clipboard
    bemenu
    mako
  ];

  # Some programs need SUID wrappers, can be configured further or are started in user sessions.
  # programs.mtr.enable = true;
  programs = {
	gnupg.agent = {
	    enable = true;
	    enableSSHSupport = true;
	};
	# android debug bridge
	adb.enable = true;
	  # enable sway window manager
	sway = {
	    enable = true;
	    wrapperFeatures.gtk = true;
	};
  };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11";

  ## Container ZONE
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      # dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.dnsname.enable = true;
    };
  };
}
