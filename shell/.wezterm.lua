local wezterm = require("wezterm")

local config = wezterm.config_builder()
config.automatically_reload_config = true 

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 16

config.initial_cols = 120
config.initial_rows = 36

config.enable_tab_bar = false
config.window_decorations = "RESIZE"

config.window_background_opacity = 0.95
config.macos_window_background_blur = 10

config.colors = {
  foreground = "#c6cad7",
  background = "#12141a",
  cursor_bg = "#ffd866",
  cursor_border = "#ffd866",
  cursor_fg = "#12141a",
  selection_bg = "#98a2b5",
  selection_fg = "#12141a",

  ansi = {
    "#12141a",
    "#fc6a67",
    "#a9dc76",
    "#ffd866",
    "#78dce8",
    "#e991e3",
    "#78e8c6",
    "#12141a",
  },
  
  brights = {
    "#404658",
    "#ff6764",
    "#a9f65c",
    "#ffd866",
    "#61eeff",
    "#fd7df4",
    "#61ffcf",
    "#404658",
  },

  tab_bar = {
    background = "#171921",
    active_tab = {
      bg_color = "#12141a",
      fg_color = "#98a2b5",
      underline = "None",
    },
    inactive_tab = {
      bg_color = "#171921",
      fg_color = "#4c526b",
    },
    inactive_tab_hover = {
      bg_color = "#12141a",
      fg_color = "#98a2b5",
    },
    new_tab = {
      bg_color = "#171921",
      fg_color = "#98a2b5",
    },
    new_tab_hover = {
      bg_color = "#12141a",
      fg_color = "#ffd866",
    },
  },

  scrollbar_thumb = "#c6cad7",

  split = "#0a0b0f",

  visual_bell = "#fc6a67",

  compose_cursor = "#fc9867",
}

return config
