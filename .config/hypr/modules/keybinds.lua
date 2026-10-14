local mainMod = "SUPER"
local terminal = "kitty"
local menu = "rofi -show drun"
local windowSwitcher = "rofi -show window"

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal), {
    description = "Open terminal",
})
hl.bind("ALT + Space", hl.dsp.exec_cmd(menu), {
    description = "Open application launcher",
})
hl.bind("ALT + TAB", hl.dsp.exec_cmd(windowSwitcher), {
    description = "Open application launcher",
})
hl.bind(mainMod .. " + Q", hl.dsp.window.close(), {
    description = "Close active window",
})
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit(), {
    description = "Exit Hyprland",
})
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({
    mode = "fullscreen",
    action = "toggle",
}), {
    description = "Toggle fullscreen",
})
hl.bind(mainMod .. " + Space", hl.dsp.window.float({ action = "toggle" }), {
    description = "Toggle floating",
})
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f -'), {
    description = "Capture and annotate a screen region",
})

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }), {
    description = "Focus left",
})
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }), {
    description = "Focus down",
})
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }), {
    description = "Focus up",
})
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }), {
    description = "Focus right",
})

hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.resize({x = -10, y = 10, relative = true}), {
    description = "Resize left",
    repeating = true
})
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.resize({x = 0, y = -10, relative = true}), {
    description = "Resize down",
    repeating = true
})
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.resize({x = 0, y = 10, relative = true}), {
    description = "Resize up",
    repeating = true
})
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.resize({x = 10, y = 0, relative = true}), {
    description = "Resize right",
    repeating = true
})

for workspace = 1, 9 do
    hl.bind(mainMod .. " + " .. workspace, hl.dsp.focus({ workspace = workspace }), {
        description = "Switch to workspace " .. workspace,
    })
    hl.bind(mainMod .. " + SHIFT + " .. workspace, hl.dsp.window.move({
        workspace = workspace,
    }), {
        description = "Move window to workspace " .. workspace,
    })
end

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
-- hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), {
    locked = true,
    repeating = true,
})
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), {
    locked = true,
    repeating = true,
})
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), {
    locked = true,
})
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), {
    locked = true,
})
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -d intel_backlight -e4 -n2 set 5%+"), {
    locked = true,
    repeating = true,
})
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -d intel_backlight -e4 -n2 set 5%-"), {
    locked = true,
    repeating = true,
})
