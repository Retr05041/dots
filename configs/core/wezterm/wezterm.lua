local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.colors = { background = 'black' }
config.color_scheme = 'Tokyo Night'
config.enable_tab_bar = false
config.enable_scroll_bar = false
config.window_background_opacity = 0.9
config.font = wezterm.font 'Hack Nerd Font'

return config
