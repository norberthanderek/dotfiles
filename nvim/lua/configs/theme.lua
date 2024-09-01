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
}

function M.setup()
	local colors = M.colors

	vim.wo.number = true
	vim.wo.relativenumber = true
	vim.wo.signcolumn = "no"

	vim.o.list = true
	vim.o.listchars = "tab:→ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨"
	vim.o.showbreak = "↪"

	vim.cmd("highlight clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end
	vim.o.background = "dark"
	vim.o.termguicolors = true

	vim.g.colors_name = "Bearded Monokai Reversed"

	vim.cmd("highlight Normal guifg=" .. colors.foreground .. " guibg=" .. colors.background)
	vim.cmd("highlight Cursor guifg=" .. colors.cursor_fg .. " guibg=" .. colors.cursor_bg)
	vim.cmd("highlight Visual guifg=" .. colors.selection_fg .. " guibg=" .. colors.selection_bg)
	vim.cmd("highlight LineNr guifg=" .. colors.bright_black)
	vim.cmd("highlight StatusLine guifg=" .. colors.foreground .. " guibg=" .. colors.tabline_bg)
	vim.cmd("highlight StatusLineNC guifg=" .. colors.inactive_tab_fg .. " guibg=" .. colors.inactive_tab_bg)
	vim.cmd("highlight TabLine guifg=" .. colors.inactive_tab_fg .. " guibg=" .. colors.inactive_tab_bg)
	vim.cmd("highlight TabLineSel guifg=" .. colors.tabline_fg .. " guibg=" .. colors.tabline_bg)
	vim.cmd("highlight TabLineFill guibg=" .. colors.tabline_bg)

	vim.cmd("highlight Comment guifg=" .. colors.bright_black)
	vim.cmd("highlight Constant guifg=" .. colors.red)
	vim.cmd("highlight String guifg=" .. colors.green)
	vim.cmd("highlight Identifier guifg=" .. colors.blue)
	vim.cmd("highlight Statement guifg=" .. colors.yellow)
	vim.cmd("highlight PreProc guifg=" .. colors.magenta)
	vim.cmd("highlight Type guifg=" .. colors.cyan)
	vim.cmd("highlight Special guifg=" .. colors.bright_red)
	vim.cmd("highlight Underlined guifg=" .. colors.blue)
	vim.cmd("highlight Todo guifg=" .. colors.magenta)
	vim.cmd("highlight Error guifg=" .. colors.bright_red .. " guibg=" .. colors.background)
	vim.cmd("highlight WarningMsg guifg=" .. colors.yellow)
	vim.cmd("highlight Search guifg=" .. colors.bright_white .. " guibg=" .. colors.visual)
	vim.cmd("highlight IncSearch guifg=" .. colors.background .. " guibg=" .. colors.yellow)
	vim.cmd("highlight VisualNOS guifg=" .. colors.bright_white .. " guibg=" .. colors.visual)
	vim.cmd("highlight NonText guifg=" .. colors.bright_black)

	vim.api.nvim_set_hl(0, "NonText", { fg = colors.background })
end

return M
