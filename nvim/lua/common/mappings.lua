local keymap_opts = { noremap = true, silent = true }

-- Reload neovim config
vim.keymap.set('n', '<leader>rc', ':source ~/.config/nvim/init.lua <CR>', keymap_opts)

-- Remap `Ctrl+s` to save the current buffer
vim.keymap.set('n', '<C-s>', ':w<CR>', keymap_opts)
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>a', keymap_opts)

-- Remap `Ctrl+c` to copy to clipboard
vim.keymap.set('v', '<C-c>', '"+y', keymap_opts)

-- Remap `Ctrl+v` to paste from clipboard
vim.keymap.set('n', '<C-v>', '"+p', keymap_opts)
vim.keymap.set('i', '<C-v>', '<Esc>"+pa', keymap_opts)

-- Paste without overwriting clipboard in visual mode
vim.keymap.set('v', 'p', '"_dP', keymap_opts)