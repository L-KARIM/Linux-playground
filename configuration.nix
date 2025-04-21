# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

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

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.cpu.amd.updateMicrocode = true;

  services.xserver.videoDrivers = [ "nvidia" ];  # Hybrid GPU, see below
  
 
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false; # use proprietary NVIDIA driver
    nvidiaSettings = true;

    prime = {
      # You must check these with `lspci | grep VGA`
      offload.enable = true;
      offload.enableOffloadCmd = true;
      intelBusId = "PCI:6:0:0";     # replace with your AMD iGPU
      nvidiaBusId = "PCI:1:0:0";    # replace with your RTX 3070
    };
  };

  # For OpenGL/Steam/etc.
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

hardware.bluetooth.enable = true;
services.blueman.enable = true;

powerManagement.enable = true;
services.tlp.enable = true;


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
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
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.techevolab = {
    isNormalUser = true;
    description = "TechEvoLab";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };


   
 
  programs.steam.enable = true;
 

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
 # hyprland
  pkgs.waybar        # Optional: status bar
   pkgs.alacritty     # Optional: terminal
  pkgs.wl-clipboard
   pkgs.htop
   pkgs.btop
   pkgs.neofetch
   pkgs.obs-studio
   pkgs.libreoffice-still
   #vim
   pkgs.git
   pkgs.vlc
   pkgs.brave
   pkgs.kitty
   pkgs.vscode-extensions.ms-python.python
   pkgs.python312Packages.ipykernel
   pkgs.python3
   pkgs.python3Packages.pip
   pkgs.python3Packages.ipykernel

  # pkgs.zsh
   pkgs.efibootmgr
   pkgs.python39
   pkgs.python312Packages.numpy
   pkgs.python312Packages.pandas
pkgs.python312Packages.matplotlib
pkgs.python312Packages.streamlit
pkgs.cmatrix
pkgs.vscode-fhs  
 nvidia-settings
  #  wget 
  pkgs.curl
pkgs. wget
   pkgs.unzip
  pkgs.gnome.gnome-tweaks
  pkgs.zsh

  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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
  system.stateVersion = "24.11"; # Did you read the comment?

}
