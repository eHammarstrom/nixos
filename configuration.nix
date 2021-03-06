# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  hemacs = (pkgs.emacs.override {}).overrideAttrs (old: {
    nativeBuildInputs = (old.nativeBuildInputs or []) ++ [ pkgs.haskellPackages.cabal-install ];
  });
in {
  nixpkgs.config.allowUnfree = true;

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./xserver.nix
      ./bash.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    grub.device = "/dev/disk/by-uuid/54DD-03F5";
    grub.useOSProber = true;
  };

  networking.hostName = "nixbox"; # Define your hostname.

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    wget curl vim
    git cabal-install
    cabal2nix ghc clang
    gcc hexchat zip
    unzip discord alacritty
  ];

  environment.variables = { PATH = "/home/estrom/.cargo/bin"; };

  fonts.fonts = with pkgs; [
    hasklig
    fira-code
    fira-code-symbols
    hack-font
  ];

  # List services that you want to enable:

  # Enable the one true service
  services.emacs.enable = true;
  services.emacs.defaultEditor = true;
  services.emacs.package = hemacs;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;

    daemon.config = {
      default-sample-format = "s24ne";
      default-sample-rate = "192000";
      alternate-sample-rate = "96000";
    };
  };

  # Nvidia 32bit support
  hardware.opengl.driSupport32Bit = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?

}
