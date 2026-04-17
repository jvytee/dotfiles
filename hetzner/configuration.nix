# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:

{
  boot.loader.grub.enable = true;

  networking = {
    hostName = "hetzner01"; # Define your hostname.
    useNetworkd = true;

    # Open ports in the firewall.
    firewall = {
      allowedTCPPorts = [ 22 ];
      allowedUDPPorts = [ ];
      # Or disable the firewall altogether.
      # enable = false;
    };
  };

  systemd.network = {
    enable = true;
    networks.hetzner = {
      matchConfig.name = "enp1s0";
      networkConfig.DHCP = "ipv4";
      address = [
        "2a01:4f8:c013:57ea::1/64"
      ];
      routes = [
        { Gateway = "fe80::1"; }
      ];
    };
  };

  nix.gc = {
    automatic = true;
    dates = "03:15";
  };

  system.autoUpgrade = {
    enable = true;
    dates = "Sun *-*-* 04:40";
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "de";
    useXkbConfig = true; # use xkb.options in tty.
  };

  users = {
    groups.git = { };

    users = {
      # Define a user account. Don't forget to set a password with ‘passwd’.
      julian = {
        isNormalUser = true;
        extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
        initialHashedPassword = "$y$j9T$vopojNBRmJnHKUHHMsN4Z1$n2JyUEEiqRxu6S0wWvAQbxQ0NwqQUuDtxqNx2taTvF6";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIXsa+rFKFESXeTR+AQGaI4GcxIFY1U0RkWu/aJr+8Eo julian"
        ];
      };

      git = {
        isSystemUser = true;
        group = "git";
        home = "/var/lib/git-server";
        createHome = true;
        shell = "${pkgs.git}/bin/git-shell";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIXsa+rFKFESXeTR+AQGaI4GcxIFY1U0RkWu/aJr+8Eo julian"
        ];
      };
    };
  };

  # programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    bat
    curl
    git
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services = {
    # Enable the X11 windowing system.
    # xserver.enable = true;

    # Configure keymap in X11
    xserver.xkb = {
      layout = "de";
      options = "caps:swapescape";
    };

    # Enable CUPS to print documents.
    # printing.enable = true;

    # Enable sound.
    # pulseaudio.enable = true;
    # OR
    # pipewire = {
    #   enable = true;
    #   pulse.enable = true;
    # };

    # Enable touchpad support (enabled default in most desktopManager).
    # libinput.enable = true;

    # Enable the OpenSSH daemon.
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
      };
      extraConfig = ''
        Match user git
          AllowTcpForwarding no
          AllowAgentForwarding no
          PermitTTY no
          X11Forwarding no
      '';
    };
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}
