{ config, pkgs, ... }:

let
    pkgsStable = import <stable> { inherit (pkgs) system; };
in

{
  imports = 
    [ 
      ./hardware-configuration.nix 
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  services.getty.autologinUser = "moota";

  networking.hostName = "moota"; # Define your hostname.
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;

  networking.firewall.allowedTCPPorts = [24800];

  programs.localsend.enable = true;
  programs.kdeconnect.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_CH.UTF-8";
    LC_IDENTIFICATION = "fr_CH.UTF-8";
    LC_MEASUREMENT = "fr_CH.UTF-8";
    LC_MONETARY = "fr_CH.UTF-8";
    LC_NAME = "fr_CH.UTF-8";
    LC_NUMERIC = "fr_CH.UTF-8";
    LC_PAPER = "fr_CH.UTF-8";
    LC_TELEPHONE = "fr_CH.UTF-8";
    LC_TIME = "fr_CH.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  # services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "ch";
    variant = "fr";
  };

  fonts = {
    enableDefaultPackages = true; # optional but nice
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
  };
  # Configure console keymap
  console.keyMap = "sg";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support.
  services.libinput.enable = true;

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true; 
  }; 
  # Define a user account.
  users.users.moota = {
    isNormalUser = true;
    description = "Elton";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "moota";

  # Enable FlatPak
  services.flatpak.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Switch to unstable
  nixpkgs.config.unstable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.dbus.enable = true;
  security.polkit.enable = true;

  xdg.portal = {
    enable = true;
    config.common.default = "kde";
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  services.hypridle.enable = true;

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
 
   programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  }; 
  
  programs.neovim = {
    enable = true;
    defaultEditor = true; 
    viAlias = true;
    vimAlias = true;
  }; 

  programs.zsh = {
	  enable = true;
	  enableCompletion = true;

	  promptInit = ''
		  eval "$(starship init zsh)"
		  '';
  };

  environment.systemPackages = with pkgs; [
    vscode.fhs
    kitty
    git
    home-manager
    input-leap
    wl-clipboard
    starship
    foot
    waybar
    wget
    hyprpaper
];

  system.stateVersion = "24.11"; # Did you read the comment?
}

