{ inputs, config, pkgs, ... }:

{
  imports =
    [ ./hardware.nix ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable the SDDM display manager.
  services.displayManager.sddm.enable = true;

  # Enable Cachix (https://wiki.hyprland.org/Nix/Cachix/)
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  # Enable hyprland (https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/)
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11.
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Hostname.
  networking.hostName = "niki";

  # Enable networking.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account.
  users.users.y = {
    isNormalUser = true;
    description = "y";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      micro
      neovim
      xterm
      vscodium
      chromium
      git
      vlc
      p7zip
      archiver
      fzf
      bat
      eza
      btop
      fastfetch
      meld
      ripgrep
      tmux
      tldr
      ffmpeg
      gparted
      localsend
      catppuccin-cursors.mochaMauve
    ];
  };

  # INSTALL PACKAGES
  environment.systemPackages = with pkgs; [

    # KDE DOLPHIN
    kdePackages.dolphin
    kdePackages.dolphin-plugins
    kdePackages.ark
    kdePackages.konsole
    kdePackages.kio-admin
    kdePackages.breeze-icons

    # ICONS
    dracula-icon-theme
    nordzy-icon-theme
    epapirus-icon-theme
    morewaita-icon-theme
    la-capitaine-icon-theme
    gnome-icon-theme

    # status bar
    waybar
    # notifications
    dunst
    libnotify
    # wallpaper
    hyprpaper
    # terminal
    kitty
    # app launcher
    rofi-wayland
    # screenshots
    grim
    slurp
    # clipboard
    wl-clipboard
    # file manager
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin
    # fonts
    font-awesome
    hack-font
    fira-code
    fira-code-nerdfont
    # logout menu
    wlogout
    # GTK theme
    magnetic-catppuccin-gtk
    tokyonight-gtk-theme
    # KDE theme
    catppuccin-kvantum
    # Setup GTK themes (.icons .themes)
    nwg-look
    # QT themes stuff
    libsForQt5.qt5ct
    kdePackages.qt6ct
    themechanger
    kdePackages.qtstyleplugin-kvantum
    qt5.qtwayland
    qt6.qtwayland
    # XDG portal
    xdg-desktop-portal-hyprland
    # UTILS
    pavucontrol
    polkit_gnome
    hyprpicker
    wtype
  ];


  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # Enable the firewall.
  networking.firewall.enable = true;

  # Open ports in the firewall (localsend, syncthing).
  networking.firewall.allowedTCPPorts = [ 53317 8384 ];
  networking.firewall.allowedUDPPorts = [ 53317 8384 ];

  # Installation ISO.
  system.stateVersion = "24.05";

  # Automatic Garbage Collection.
  nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
      };

  # Enable virt-manager guest.
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  # Enable fish.
  programs.fish.enable = true;

  # Enable flakes.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
