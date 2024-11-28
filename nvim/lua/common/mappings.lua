local keymap_opts = { noremap = true, silent = true }

-- Reload neovim config
vim.keymap.set("n", "<leader>rc", ":source ~/.config/nvim/init.lua <CR>", keymap_opts)

-- Remap `Ctrl+s` to save the current buffer
vim.keymap.set("n", "<C-s>", ":w<CR>", keymap_opts)
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", keymap_opts)
