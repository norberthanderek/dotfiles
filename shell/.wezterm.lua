local wezterm = require("wezterm")

local config = wezterm.config_builder()
config.automatically_reload_config = true

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 16

config.initial_cols = 120
config.initial_rows = 36

config.default_cursor_style = "SteadyBar"

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.95
config.macos_window_background_blur = 10

-- Multiplexer
config.leader = { key = "q", mods = "ALT", timeout_milliseconds = 2000 }
config.keys = {
  {
    mods = "LEADER",
    key = "c",
    action = wezterm.action.SpawnTab("CurrentPaneDomain"),
  },
  {
    mods = "LEADER",
    key = "x",
    action = wezterm.action.CloseCurrentPane({ confirm = true }),
  },
  {
    mods = "LEADER",
    key = "|",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    mods = "LEADER",
    key = "-",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    mods = "CTRL",
    key = "b",
    action = wezterm.action.ActivateTabRelative(-1),
  },
  {
    mods = "CTRL",
    key = "n",
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    mods = "CTRL",
    key = "h",
    action = wezterm.action.ActivatePaneDirection("Left"),
  },
  {
    mods = "CTRL",
    key = "j",
    action = wezterm.action.ActivatePaneDirection("Down"),
  },
  {
    mods = "CTRL",
    key = "k",
    action = wezterm.action.ActivatePaneDirection("Up"),
  },
  {
    mods = "CTRL",
    key = "l",
    action = wezterm.action.ActivatePaneDirection("Right"),
  },
  {
    mods = "LEADER",
    key = "LeftArrow",
    action = wezterm.action.AdjustPaneSize({ "Left", 10 }),
  },
  {
    mods = "LEADER",
    key = "RightArrow",
    action = wezterm.action.AdjustPaneSize({ "Right", 10 }),
  },
  {
    mods = "LEADER",
    key = "DownArrow",
    action = wezterm.action.AdjustPaneSize({ "Down", 10 }),
  },
  {
    mods = "LEADER",
    key = "UpArrow",
    action = wezterm.action.AdjustPaneSize({ "Up", 10 }),
  },
  {
    mods = 'LEADER',
    key = 'f',
    action = wezterm.action.ToggleFullScreen,
  },
  {
    mods = 'LEADER',
    key = 'q',
    action = wezterm.action.QuitApplication,
  },
}

for i = 0, 9 do
  -- leader + number to activate that tab
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = wezterm.action.ActivateTab(i),
  })
end

-- Tab bar
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true

-- Status
wezterm.on("update-right-status", function(window, _)
  local SOLID_LEFT_ARROW = ""
  local ARROW_FOREGROUND = { Foreground = { Color = "#c6cad7" } }
  local prefix = ""

  if window:leader_is_active() then
    prefix = " " .. utf8.char(0x26A1) -- ocean wave
    SOLID_LEFT_ARROW = utf8.char(0xe0b2)
  end

  if window:active_tab():tab_id() ~= 0 then
    ARROW_FOREGROUND = { Foreground = { Color = "#1e2030" } }
  end -- arrow color based on if tab is first pane

  window:set_left_status(wezterm.format({
    { Text = prefix },
    ARROW_FOREGROUND,
    { Text = SOLID_LEFT_ARROW },
  }))
end)

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
