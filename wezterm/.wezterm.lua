-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- No bell
config.audible_bell = "Disabled"

-- Window config
-- config.color_scheme = 'Dracula'
config.color_scheme = "Catppuccin Mocha"
-- config.window_background_opacity = 0.95
-- config.macos_window_background_blur = 10

config.window_padding = {
  left = 3,
  right = 0,
  top = 0,
  bottom = 0,
}

-- Tabs
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
wezterm.on(
  'format-tab-title',
  function(tab)
    local title = tab.tab_index
    if tab.is_active then
      return {
        { Text = ' <' .. title .. '> ' }
      }
    else
      return {
        { Text = '|' .. title .. '|' }
      }
    end
  end
)

-- Font
config.font_size = 17
config.font = wezterm.font 'BlexMono Nerd Font'
config.keys = {
  {
    key = 'w',
    mods = 'CTRL|ALT',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
}

-- and finally, return the configuration to wezterm
return config
