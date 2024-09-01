local nvim_tree = require("nvim-tree")

nvim_tree.setup({
	disable_netrw = true,
	hijack_cursor = true,
	sync_root_with_cwd = true,
	update_focused_file = {
		enable = true,
		update_root = false,
	},
	filters = { dotfiles = false },
	view = {
		width = 30,
		preserve_window_proportions = true,
	},
	renderer = {
		root_folder_label = false,
		highlight_git = true,
		indent_markers = { enable = true },
		icons = {
			glyphs = {
				default = "󰈚",
				folder = {
					default = "",
					empty = "",
					empty_open = "",
					open = "",
					symlink = "",
				},
				git = {
					unstaged = "U",
					staged = "S",
					unmerged = "M",
					renamed = "R",
					untracked = "N",
					deleted = "D",
					ignored = "I",
				},
			},
			git_placement = "after",
		},
	},
})

local keymap_opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>", keymap_opts)
vim.keymap.set("n", "<leader>e", ":NvimTreeFocus<CR>", keymap_opts)
