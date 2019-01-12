{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    layout = "us";

    desktopManager = {
      default = "none";
      xterm.enable = false;
    };

    libinput.enable = true;

    videoDrivers = [ "nvidia" ];

    windowManager.i3.enable = true;

    xrandrHeads = [ "DP-0"
                    { output = "DVI-D-0";
                      monitorConfig = ''
                        HorizSync 30.0 - 160.0
                        VertRefresh 56.0 - 144.0
                        Option "DPMS
                      '';
                    }
                  ];

    screenSection = ''
      DefaultDepth    24
      Option         "Stereo" "0"
      Option         "nvidiaXineramaInfoOrder" "DFP-0"
      Option         "metamodes" "DVI-D-0: 1920x1080_144 +3840+540, DP-0: nvidia-auto-select +0+0"
      Option         "SLI" "Off"
      Option         "MultiGPU" "Off"
      Option         "BaseMosaic" "off"
      SubSection     "Display"
        Depth       24
      EndSubSection
    '';
  };
}

