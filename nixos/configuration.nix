# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    <nixos-hardware/lenovo/thinkpad/t460>
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.enableRedistributableFirmware = true;
  nixpkgs.config.allowUnfree = true;
  nix = {
    package = pkgs.lixPackageSets.stable.lix;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  networking = {
    hostName = "klapprechner"; # Define your hostname.
    # Pick only one of the below networking options.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;  # Easiest to use and most distros use this by default.
    nameservers = [
      "9.9.9.9"
      "149.112.112.112"
      "2620:fe::fe"
      "2620:fe::9"
    ];
    firewall.checkReversePath = false;

    wg-quick.interfaces.uwupn = {
      autostart = false;
      configFile = "/etc/nixos/uwupn.conf";
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "de";
    useXkbConfig = true; # use xkb.options in tty.
  };

  services = {
    btrfs.autoScrub.enable = true;

    # Enable sound.
    # pulseaudio.enable = true;
    # OR
    pipewire = {
      enable = true;
      pulse.enable = true;
    };

    # Enable CUPS to print documents.
    printing = {
      enable = true;
      drivers = [ pkgs.brlaser ];
    };

    resolved = {
      enable = true;
      dnsovertls = "true";
    };

    syncthing = {
      enable = true;
      user = "julian";
      dataDir = "/home/julian";
      configDir = "/home/julian/.config/syncthing";
    };

    # Enable the X11 windowing system.
    xserver = {
      enable = true;

      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;

      videoDrivers = [ "displaylink" ];

      # Configure keymap in X11
      xkb.layout = "de";
      xkb.options = "caps:swapescape";
    };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # openssh.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.julian = {
    description = "Julian";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    isNormalUser = true;
    packages = with pkgs; [
      borgbackup
      ((emacsPackagesFor emacs-pgtk).emacsWithPackages (emacsPackages:
        [emacsPackages.vterm]
      ))
      inkscape
      keepassxc
      lazygit
      libreoffice
      obsidian
      quodlibet
      stow
      tdesktop
      vlc
    ];
    shell = pkgs.zsh;
  };

  programs = {
    direnv.enable = true;
    firefox.enable = true;
    gnome-terminal.enable = true;
    thunderbird.enable = true;
    starship.enable = true;

    fzf = {
      fuzzyCompletion = true;
      keybindings = true;
    };

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    gnupg.agent = {
      enable = true;
      # enableSSHSupport = true;
    };

    neovim = {
      enable = true;
      defaultEditor = true;
    };

    zsh = {
      enable = true;
      autosuggestions.enable = true;
      enableCompletion = true;
      histFile = "~/.histfile";
      histSize = 1000;
      interactiveShellInit = ''
        function start-application-mode { echoti smkx }
        function stop-application-mode { echoti rmkx }
        autoload -Uz add-zle-hook-widget
        add-zle-hook-widget -Uz zle-line-init start-application-mode
        add-zle-hook-widget -Uz zle-line-finish stop-application-mode

        bindkey "$terminfo[kdch1]" delete-char
        bindkey "$terminfo[khome]" beginning-of-line
        bindkey "$terminfo[kend]" end-of-line

        function set_window_title() { echo -ne "\033]0;$(basename $PWD)\007" }
        precmd_functions+=(set_window_title)
      '';
      # promptInit = ''eval "$(starship init zsh)"'';
      setOptions = [
        "autocd"
        "nobeep"
      ];
      shellAliases = {
        ip = "ip -c";
        ls = "eza";
      };
      syntaxHighlighting.enable = true;
    };
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    bat
    curl
    dig
    eza
    fd
    git
    gnome-tweaks
    nil
    nixfmt
    ripgrep
  ];

  fonts.packages = with pkgs; [
    font-awesome
    inter
    lato
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
    noto-fonts
  ];

  virtualisation.podman.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

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
  system.stateVersion = "25.05"; # Did you read the comment?

}

