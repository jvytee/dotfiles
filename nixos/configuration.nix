# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      <nixos-hardware/lenovo/thinkpad/t460s>
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices.cryptlvm-nixos.device = "/dev/disk/by-uuid/4ea3800a-a562-44d4-8ccc-ca788e5ed942";

  networking.hostName = "klapprechner"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp4s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  };

  # Enable the GNOME 3 Desktop Environment.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;
  

  # Configure keymap in X11
  services.xserver.layout = "de";
  services.xserver.xkbOptions = "caps:swapescape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.julian = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    (import ./neovim.nix)
    bat
    binutils
    borgbackup
    clang-tools
    darktable
    element-desktop
    exa
    fd
    firefox
    fzf
    gcc
    gdb
    git
    gnome3.gnome-tweaks
    gnupg
    gradle
    jetbrains.idea-community
    jdk14
    kotlin
    nodejs
    pass
    pinentry-gnome
    python3
    ripgrep
    rust-analyzer
    rustup
    starship
    stow
    tdesktop
    thunderbird
    vlc
  ];

  fonts.fonts = with pkgs; [
    iosevka
    noto-fonts
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    bash = {
      interactiveShellInit = ''
        source $(fzf-share)/completion.bash
        source $(fzf-share)/key-bindings.bash
      '';
      promptInit = "eval \"$(starship init bash)\"";
      shellAliases = {
	ls = "exa";
	ip = "ip -c";
	vim = "nvim";
      };
    };
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  services = {
    syncthing = {
      enable = true;
      user = "julian";
      dataDir = "/home/julian";
      configDir = "/home/julian/.config/syncthing";
    };

    tlp.enable = true;
  };

  virtualisation.podman.enable = true;

  # Environment variables
  environment.variables = {
    EDITOR = "nvim";
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_USE_XINPUT2 = "1";
    QT_QPA_PLATFORM = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

