require("modules.monitors")
require("modules.keybinds")

hl.env("AQ_DRM_DEVICES", "/dev/dri/intel-igpu:/dev/dri/nvidia-dgpu")

hl.on("hyprland.start", function()
    hl.exec_cmd("mako")
    hl.exec_cmd("hyprpaper")
end)

hl.config({
    input = {
        kb_layout = "us",
        follow_mouse = 1,
    },
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        layout = "dwindle",
    },
    ecosystem = {
      no_donation_nag = true,
      no_update_news = true,
    },
})

