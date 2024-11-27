-- Pull in wezterm API
local wezterm = require("wezterm")

-- Config
local config = wezterm.config_builder()

config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 16
-- config.enable_tab_bar = false
config.window_decorations = "RESIZE"
-- config.window_background_opacity = 0.8
-- config.macos_window_background_blur = 10

config.color_scheme = "Catppuccin Frappe"

return config
