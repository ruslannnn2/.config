{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/cardwired.nix
  ];

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-settings"
      "nvidia-x11"
      "slack"
      "terraform"
      "cider-2"
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 5;

  boot.kernelPackages = pkgs.linuxPackages_6_18;
  boot.kernelParams = [ "i915.enable_dpcd_backlight=3" ];

  networking.hostName = "rusmachine";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";

  security.rtkit.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ intel-media-driver ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;

    powerManagement = {
      enable = true;
      finegrained = true;
    };

    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";

      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;

    settings = {
      General = {
        Experimental = true;
      };
    };
  };

  services.blueman.enable = true;

  services.asusd.enable = true;

  environment.etc."asusd/.keep".text = "";

  services.udev.extraRules = ''
    KERNEL=="card*", KERNELS=="0000:00:02.0", SUBSYSTEM=="drm", SUBSYSTEMS=="pci", SYMLINK+="dri/intel-igpu"
    KERNEL=="card*", KERNELS=="0000:01:00.0", SUBSYSTEM=="drm", SUBSYSTEMS=="pci", SYMLINK+="dri/nvidia-dgpu"
  '';

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  users.users.ruslan = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

  services.getty.autologinUser = "ruslan";

  programs.bash.loginShellInit = ''
    if [[ "$(tty)" == "/dev/tty1" ]] && uwsm check may-start; then
      exec uwsm start -e -D Hyprland hyprland.desktop
    fi
  '';

  environment.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
  services.tailscale.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  programs.waybar.enable = true;

  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    gh
    ripgrep
    fd
    unzip
    curl
    rustc
    cargo
    kitty
    rofi
    btop
    wlr-randr
    brightnessctl
    mako
    tmux
    awscli2
    ssm-session-manager-plugin
    bibata-cursors
    gzip
    gnutar
    nodejs
    python3
    codex
    helium
    hyprpaper
    grim
    slurp
    swappy
    slack
    nwg-look
    gsettings-desktop-schemas
    dconf
    coder
    mosh
    tailscale
    yazi
    fastfetch
    cider-2

    #lsp
    clang-tools
    vscode-langservers-extracted
    lua-language-server
    svelte-language-server
    vtsls
    rust-analyzer
    nixd
    nixfmt

  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "26.05"; # Did you read the comment?

}
