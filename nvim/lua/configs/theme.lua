local M = {}

M.colors = {
  foreground = "#c6cad7",
  background = "#12141a",
  cursor_bg = "#ffd866",
  cursor_fg = "#12141a",
  selection_bg = "#98a2b5",
  selection_fg = "#12141a",

  black = "#12141a",
  red = "#fc6a67",
  green = "#a9dc76",
  yellow = "#ffd866",
  blue = "#78dce8",
  magenta = "#e991e3",
  cyan = "#78e8c6",
  white = "#c6cad7",

  bright_black = "#404658",
  bright_red = "#ff6764",
  bright_green = "#a9f65c",
  bright_yellow = "#ffd866",
  bright_blue = "#61eeff",
  bright_magenta = "#fd7df4",
  bright_cyan = "#61ffcf",
  bright_white = "#f0f1f3",

  visual = "#98a2b5",
  tabline_bg = "#171921",
  tabline_fg = "#98a2b5",
  inactive_tab_bg = "#171921",
  inactive_tab_fg = "#4c526b",

  whitespace = "#1d262f",
}

function M.setup()
  local colors = M.colors

  vim.wo.number = true
  vim.wo.relativenumber = true
  vim.wo.signcolumn = "no"

  vim.opt.list = true
  vim.opt.listchars = "tab:→ ,eol:↲,space:•,trail:~,extends:⟩,precedes:⟨"
  vim.opt.showbreak = "↪"

  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  vim.opt.background = "dark"
  vim.opt.termguicolors = true

  vim.g.colors_name = "Bearded Monokai Reversed"

  vim.api.nvim_set_hl(0, "Normal", { fg = colors.foreground, bg = colors.background })
  vim.api.nvim_set_hl(0, "Cursor", { fg = colors.cursor_fg, bg = colors.cursor_bg })
  vim.api.nvim_set_hl(0, "Visual", { fg = colors.selection_fg, bg = colors.selection_bg })
  vim.api.nvim_set_hl(0, "LineNr", { fg = colors.bright_black })
  vim.api.nvim_set_hl(0, "StatusLine", { fg = colors.foreground, bg = colors.tabline_bg })
  vim.api.nvim_set_hl(0, "StatusLineNC", { fg = colors.inactive_tab_fg, bg = colors.inactive_tab_bg })
  vim.api.nvim_set_hl(0, "TabLine", { fg = colors.inactive_tab_fg, bg = colors.inactive_tab_bg })
  vim.api.nvim_set_hl(0, "TabLineSel", { fg = colors.tabline_fg, bg = colors.tabline_bg })
  vim.api.nvim_set_hl(0, "TabLineFill", { bg = colors.tabline_bg })

  vim.api.nvim_set_hl(0, "Comment", { fg = colors.bright_black })
  vim.api.nvim_set_hl(0, "Constant", { fg = colors.red })
  vim.api.nvim_set_hl(0, "String", { fg = colors.green })
  vim.api.nvim_set_hl(0, "Identifier", { fg = colors.blue })
  vim.api.nvim_set_hl(0, "Statement", { fg = colors.yellow })
  vim.api.nvim_set_hl(0, "PreProc", { fg = colors.magenta })
  vim.api.nvim_set_hl(0, "Type", { fg = colors.cyan })
  vim.api.nvim_set_hl(0, "Special", { fg = colors.bright_red })
  vim.api.nvim_set_hl(0, "Underlined", { fg = colors.blue })
  vim.api.nvim_set_hl(0, "Todo", { fg = colors.magenta })
  vim.api.nvim_set_hl(0, "Error", { fg = colors.bright_red, bg = colors.background })
  vim.api.nvim_set_hl(0, "WarningMsg", { fg = colors.yellow })
  vim.api.nvim_set_hl(0, "Search", { fg = colors.bright_white, bg = colors.visual })
  vim.api.nvim_set_hl(0, "IncSearch", { fg = colors.background, bg = colors.yellow })
  vim.api.nvim_set_hl(0, "VisualNOS", { fg = colors.bright_white, bg = colors.visual })
  vim.api.nvim_set_hl(0, "NonText", { fg = colors.background })
  vim.api.nvim_set_hl(0, "Whitespace", { fg = colors.whitespace })
end

return M
