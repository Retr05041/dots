local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Tokyo Night'
config.enable_tab_bar = false
config.enable_scroll_bar = false
config.window_background_opacity = 0.8
config.font = wezterm.font 'Hack Nerd Font'

return config
