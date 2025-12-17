-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Event handler for toggling theme
wezterm.on('toggle-theme', function(window)
  local overrides = window:get_config_overrides() or {}
  if not overrides.color_scheme then
    overrides.color_scheme = 'Gruvbox light, medium (base16)'
  else
    overrides.color_scheme = nil
  end
  window:set_config_overrides(overrides)
end)

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
-- For US International layout with dead keys
config.use_dead_keys = false
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

-- Enable IME to use XCompose
config.use_ime = true

-- Disable kitty keyboard protocol to avoid key event conflicts
config.enable_kitty_keyboard = false

-- Allow passthrough of composed characters
config.allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace"

-- Set compose key behavior
config.xim_im_name = "cedilla"

-- Explicitly disable key assignments that might interfere
config.disable_default_key_bindings = false

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

  -- Toggle between dark and light theme with CTRL + SHIFT + T
  { key = 't', mods = 'CTRL|SHIFT', action = wezterm.action.EmitEvent 'toggle-theme' },

}

-- Finally, return the configuration to wezterm:
return config
