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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices.cryptlvm-nixos.device = "/dev/disk/by-uuid/4ea3800a-a562-44d4-8ccc-ca788e5ed942";

  networking = {
    hostName = "klapprechner"; # Define your hostname.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    wireguard.enable = true;
    firewall.checkReversePath = false;
    # The global useDHCP flag is deprecated, therefore explicitly set to false here.

    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces.enp0s31f6.useDHCP = true;
    interfaces.wlp4s0.useDHCP = true;

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  };

  services = {
    # Configure keymap in X11
    xserver = {
      enable = true;
      layout = "de";
      xkbOptions = "caps:swapescape";

      # Enable the GNOME 3 Desktop Environment.
      displayManager.gdm.enable = true;
      desktopManager.gnome3.enable = true;

      # Enable touchpad support (enabled default in most desktopManager).
      libinput.enable = true;
    };

    # Enable CUPS to print documents.
    printing.enable = true;
    printing.drivers = with pkgs; [
      gutenprint
      brlaser
      brgenml1cupswrapper
    ];

    # Enable the OpenSSH daemon.
    # openssh.enable = true;

    #syncthing = {
    #  enable = true;
    #  user = "julian";
    #  dataDir = "/home/julian";
    #  configDir = "/home/julian/.config/syncthing";
    #};

    tlp = {
      enable = true;
      settings = {
        MAX_LOST_WORK_SECS_ON_BAT = 15;
      };
    };
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.julian = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    systemPackages = with pkgs; [
      ansible
      bat
      bind
      binutils
      borgbackup
      brscan4
      chromium
      darktable
      element-desktop
      emacs
      exa
      fd
      ffmpeg
      file
      firefox
      fzf
      gcc
      gdb
      git
      gnome3.gnome-tweaks
      gnumake
      gnupg
      htop
      inkscape
      jetbrains.idea-community
      jq
      kid3
      libreoffice
      lmms
      mumble
      musescore
      neofetch
      neovim
      pass-wayland
      pinentry-gnome
      powertop
      python3
      python38Packages.pip
      ripgrep
      rust-analyzer
      rustup
      starship
      stow
      tdesktop
      thunderbird
      tig
      tor
      vlc
      zotero
    ];

    gnome3 = {
      excludePackages = with pkgs.gnome3; [
        gnome-music
        epiphany
      ];
    };

    # Environment variables
    sessionVariables = {
      EDITOR = "nvim";
      MOZ_ENABLE_WAYLAND = "1";
      MOZ_USE_XINPUT2 = "1";
      QT_QPA_PLATFORM = "wayland";
      _JAVA_AWT_WM_NONREPARENTING = "1";
    };
  };

  fonts.fonts = with pkgs; [
    cantarell-fonts
    noto-fonts
  ];

  programs = {
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # mtr.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    bash = {
      enableCompletion = true;
      interactiveShellInit = ''
        source $(fzf-share)/completion.bash
        source $(fzf-share)/key-bindings.bash
      '';
      promptInit = ''eval "$(starship init bash)"'';
      shellAliases = {
	ls = "exa";
	ip = "ip -c";
	vim = "nvim";
      };
    };

    zsh = {
      enable = true;
      autosuggestions = {
        enable = true;
        highlightStyle = "fg=10";
      };
      enableCompletion = true;
      promptInit = ''eval "$(starship init zsh)"'';
      shellAliases = {
        ip = "ip -c";
        ls = "exa";
        vim = "nvim";
      };
      shellInit = ''
        source $(fzf-share)/completion.zsh
        source $(fzf-share)/key-bindings.zsh
      '';
      syntaxHighlighting.enable = true;
    };

    sway = {
      enable = true;
      extraPackages = with pkgs; [
        swaylock
        swayidle
        xwayland
        alacritty
        brightnessctl
        grim
        i3status
        imagemagick
        libnotify
        mako
        pavucontrol
        wdisplays
        wl-clipboard
        wofi
      ];
    };
  };

  qt5 = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita";
  };

  virtualisation.podman.enable = true;

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

