{  config,  lib,  pkgs,  ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.useOSProber = true;

  # Networking
  networking.hostName = "moota";
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

  programs.localsend.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Time zone. (Recheck for windows dual boot compatibility win >/< linux)
  time.timeZone = "Europe/Zurich";

  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "fr_CH.UTF-8/UTF-8"
  ];
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_CH.UTF-8";
    LC_IDENTIFICATION = "fr_CH.UTF-8";
    LC_MEASUREMENT = "fr_CH.UTF-8";
    LC_MONETARY = "fr_CH.UTF-8";
    LC_NAME = "fr_CH.UTF-8";
    LC_NUMERIC = "fr_CH.UTF-8";
    LC_TELEPHONE = "fr_CH.UTF-8";
    LC_TIME = "fr_CH.UTF-8";
  };

  services.xserver.xkb = {
    layout = "ch";
    variant = "fr";
  };

  environment.variables.LC_PAPER = "fr_CH.UTF-8";

  fileSystems = {
    "/win11" = {
      device = "/dev/disk/by-uuid/48487719487704CA";
      fsType = "ntfs3";
      options = [
        "uid=1000"
        "gid=1000"
        "windows_names"
        "exec"
        "nofail"
        "umask=0000"
      ];
    };

    "/HDD2TB" = {
      device = "/dev/disk/by-uuid/7258796F587932C9";
      fsType = "ntfs3";
      options = [
        "uid=1000"
        "gid=1000"
        "exec"
        "nofail"
      ];
    };

    "/Data" = {
      device = "/dev/disk/by-uuid/596CA0AC1A249C19";
      fsType = "ntfs3";
      options = [
        "uid=1000"
        "gid=1000"
        "windows_names"
        "exec"
        "nofail"
        "umask=0000"
      ];
    };

    "/DataBig" = {
      device = "/dev/disk/by-uuid/08D4337FD4336E56";
      fsType = "ntfs3";
      options = [
        "uid=1000"
        "gid=1000"
        "windows_names"
        "exec"
        "nofail"
        "umask=0000"
      ];
    };
  };

  console.keyMap = "sg";

  # NixOS settings
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Automatic updating
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  # Automatic cleanup
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 10d";
  nix.settings.auto-optimise-store = true;

  # Windowing
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.xserver.displayManager.setupCommands = ''
    ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-A-1 --rotate left
  '';

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    #WLR_NO_HARDWARE_CURSORS = "1";
  };

  services.hypridle.enable = true;
  programs.hyprlock.enable = true;

  ## XDG Portals
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      kdePackages.xdg-desktop-portal-kde
      xdg-desktop-portal-hyprland
    ];

    config.common.default = "*";

  };

  services.dbus.enable = true;

  # Printing.
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };
  services.printing = {
    enable = true;
    # listenAddresses = [ "*:631" ];
    allowFrom = [ "all" ];
    browsing = true;
    defaultShared = true;
    openFirewall = true;
  };

  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # Users
  users.users.moota = {
    isNormalUser = true;
    description = "Elton Mota da Silva";
    extraGroups = [
      "networkmanager"
      "wheel"
      "lp"
      "lpadmin"
      "cups"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      thunderbird
    ];
  };

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    fira-code
    fira-code-symbols
    nerd-fonts.fira-code
    atkinson-hyperlegible
  ];

  # Gaming
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  environment.variables = {
    SDL_VIDEODRIVER = "";
  };

  ## Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };
  programs.gamemode.enable = true;

  programs.neovim.defaultEditor = true;
  programs.neovim.enable = true;

  programs.kdeconnect.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  # Packages
  nixpkgs.config.allowUnfree = true;
  services.flatpak.enable = true;

  programs.zsh.enable = true;
  programs.zsh.ohMyZsh.enable = true;

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  boot.kernelModules = [
    "binder_linux"
    "ashmem_linux"
  ];
  virtualisation.waydroid.enable = true;
  boot.extraModprobeConfig = ''
    options binder_linux devices=binder,hwbinder,vndbinder
  '';

  programs.appimage.enable = true;

  services.suwayomi-server = {
    enable = true;
    settings.server = {
      host = "127.0.0.1";  # or "0.0.0.0" if you want LAN access
      port = 4567;         # change to 8081 if 4567 is taken
      basicAuthEnabled = false; # or true with creds if exposing
    };
  };
  services.flaresolverr.enable = true;
  environment.systemPackages = with pkgs; [
    home-manager
    kitty
    vscode-fhs
    discord
    htop
    ntfs3g
    tree
    git
    gnumake
    clang
    vlc
    youtube-music
    inkscape
    lutris
    prismlauncher
    heroic
    protonup-ng
    protonup-qt
    gnutls # MC Dungeons
    textsnatcher
    obsidian
    qbittorrent
    gdu
    duc
    fzf    
    fd
    gparted
    wl-clipboard
    ripgrep
    python313
    cups-browsed
    steamcmd
    ollama-rocm
    gcc
    gdb
    lua-language-server
    python312Packages.setuptools
    kdePackages.filelight
    pdfarranger
    yt-dlp
    kdePackages.qtmultimedia
    joplin-desktop
    kdePackages.kate
    kdePackages.yakuake
    jq
    wine
    bat
    go
    rustup
    ghostty
    wofi
    waybar
    font-awesome
    nixfmt-rfc-style
    hyprshot
    hyprpaper
    mako
    libnotify
    loupe
    starship
    hyprpicker
    stow
    pavucontrol
    waydroid
    fuzzel
    networkmanagerapplet
    bibata-cursors
    bitwarden-desktop
    vesktop
    brave
    kdePackages.polkit-kde-agent-1
    loupe
    scrcpy
    fastfetch
    gitkraken
    bluez
    pywal
    marksman
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  system.stateVersion = "24.05";

}
