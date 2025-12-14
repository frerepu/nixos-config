# ███╗   ███╗ ██████╗ ███╗   ██╗██╗████████╗ ██████╗ ██████╗ ██╗███╗   ██╗ ██████╗
# ████╗ ████║██╔═══██╗████╗  ██║██║╚══██╔══╝██╔═══██╗██╔══██╗██║████╗  ██║██╔════╝
# ██╔████╔██║██║   ██║██╔██╗ ██║██║   ██║   ██║   ██║██████╔╝██║██╔██╗ ██║██║  ███╗
# ██║╚██╔╝██║██║   ██║██║╚██╗██║██║   ██║   ██║   ██║██╔══██╗██║██║╚██╗██║██║   ██║
# ██║ ╚═╝ ██║╚██████╔╝██║ ╚████║██║   ██║   ╚██████╔╝██║  ██║██║██║ ╚████║╚██████╔╝
# ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝
#
# System monitoring and health check configuration

{ config, pkgs, lib, ... }:

{
  # System monitoring tools
  environment.systemPackages = with pkgs; [
    htop
    btop
    iotop
    iftop
    nethogs
    sysstat
  ];

  # Enable automatic disk usage monitoring
  systemd.services.disk-monitor = {
    description = "Monitor disk usage and warn if above 90%";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "disk-monitor" ''
        #!/bin/sh
        USAGE=$(${pkgs.coreutils}/bin/df -h / | ${pkgs.gawk}/bin/awk 'NR==2 {print $5}' | ${pkgs.gnused}/bin/sed 's/%//')
        if [ "$USAGE" -gt 90 ]; then
          ${pkgs.libnotify}/bin/notify-send -u critical "Disk Space Warning" "Root partition is $USAGE% full!"
          echo "WARNING: Disk usage at $USAGE%"
        fi
      '';
    };
  };

  # Run disk monitor daily
  systemd.timers.disk-monitor = {
    description = "Run disk usage monitor daily";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };
  };

  # Enable sysstat for system statistics collection
  services.sysstat.enable = true;
}
