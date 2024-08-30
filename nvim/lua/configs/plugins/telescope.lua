local keymap_opts = { noremap = true, silent = true }

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, keymap_opts)
vim.keymap.set("n", "<leader>fg", builtin.live_grep, keymap_opts)
vim.keymap.set("n", "<leader>fb", builtin.buffers, keymap_opts)
vim.keymap.set("n", "<leader>fn", builtin.help_tags, keymap_opts)
