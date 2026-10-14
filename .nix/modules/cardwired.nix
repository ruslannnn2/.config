{ pkgs, ... }:

{
  services.cardwired = {
    enable = true;
    settings = {
      # This Cardwire version does not identify our NVIDIA card as discrete,
      # so its built-in battery switching cannot select Integrated mode.
      battery_auto_switch = false;
      external_display_auto_switch = false;
      experimental_nvidia_block = true;
    };
  };

  systemd.services.cardwire-power-source = {
    description = "Switch Cardwire GPU access with AC power";
    requires = [ "cardwired.service" ];
    after = [ "cardwired.service" ];
    wantedBy = [ "multi-user.target" ];
    path = with pkgs; [ cardwire systemd gawk coreutils gnugrep ];
    serviceConfig = {
      Restart = "always";
      RestartSec = 2;
    };
    script = ''
      nvidia_display_connected() {
        for status in /sys/bus/pci/devices/0000:01:00.0/drm/card*/card*-*/status; do
          if [ -f "$status" ] && [ "$(cat "$status")" = connected ]; then
            return 0
          fi
        done
        return 1
      }

      apply_mode() {
        if [ "$(cat /sys/class/power_supply/ACAD/online)" = 0 ] && ! nvidia_display_connected; then
          read -r gpu_id blocked < <(cardwire list | awk '$3 == "0000:01:00.0" { print $1, $NF }')
          if [ -z "$gpu_id" ]; then
            echo "NVIDIA GPU not found in Cardwire" >&2
            return 1
          fi
          if ! cardwire get | grep -q 'Current Mode: Manual'; then
            cardwire set manual || return 1
          fi
          if [ "$blocked" != true ]; then
            cardwire gpu "$gpu_id" --block || cardwire set hybrid
          fi
        elif ! cardwire get | grep -q 'Current Mode: Hybrid'; then
          cardwire set hybrid
        fi
      }

      apply_mode
      stdbuf -oL udevadm monitor --udev --subsystem-match=power_supply --subsystem-match=drm |
        while IFS= read -r event; do
          case "$event" in
            *"(power_supply)"*|*"(drm)"*) apply_mode ;;
          esac
        done
    '';
  };
}
