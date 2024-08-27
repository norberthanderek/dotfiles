local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Reload neovim config
map('n', '<leader>rc', ':source ~/.config/nvim/init.lua <CR>', opts)

-- Remap `Ctrl+s` to save the current buffer
map('n', '<C-s>', ':w<CR>', opts)
map('i', '<C-s>', '<Esc>:w<CR>a', opts)

-- Remap `Ctrl+c` to copy to clipboard
map('v', '<C-c>', '"+y', opts)

-- Remap `Ctrl+v` to paste from clipboard
map('n', '<C-v>', '"+p', opts)
map('i', '<C-v>', '<Esc>"+pa', opts)

-- Paste without overwriting clipboard in visual mode
map('v', 'p', '"_dP', opts)