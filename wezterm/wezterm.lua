-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.
config.automatically_reload_config = true
config.enable_tab_bar = false
config.font_size = 12.0

-- config.color_scheme = 'Gruvbox light, soft (base16)'
config.color_scheme = 'Gruvbox dark, pale (base16)'

config.window_decorations = "RESIZE"
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- font
-- sudo pacman -S ttf-jetbrains-mono-nerd noto-fonts-emoji
config.font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Regular' })

-- Enable cedilla and dead keys support
config.use_dead_keys = false
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false
config.use_ime = true

-- Disable audible bell
config.audible_bell = "Disabled"

-- Keyboard shortcuts for font size adjustment
config.keys = {
  -- Reset font size with CTRL + =
  { key = '=', mods = 'CTRL', action = wezterm.action.ResetFontSize },

  -- Increase font size with CTRL + +
  { key = '+', mods = 'CTRL', action = wezterm.action.IncreaseFontSize },

  -- Decrease font size with CTRL + -
  { key = '-', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },
}

-- Finally, return the configuration to wezterm:
return config
