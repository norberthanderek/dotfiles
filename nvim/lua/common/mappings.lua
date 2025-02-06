-- Enable timeout for mappings
vim.opt.timeout = true
vim.opt.timeoutlen = 2500 -- (ms)

local keymap_opts = { noremap = true, silent = true }

-- Map Enter key in normal mode to clear search highlights
vim.keymap.set("n", "<Esc>", ":noh<CR><Esc>", keymap_opts)

-- Remap `Ctrl+s` to save the current buffer
vim.keymap.set("n", "<C-s>", ":w<CR>", keymap_opts)
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", keymap_opts)
