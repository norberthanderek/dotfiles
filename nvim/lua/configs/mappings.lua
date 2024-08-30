local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Navigator support (WezTerm & Tmux)
map('n', '<C-h>', '<cmd>NavigatorLeft<CR>', opts)
map('n', '<C-l>', '<cmd>NavigatorRight<CR>', opts)
map('n', '<C-j>', '<cmd>NavigatorDown<CR>', opts)
map('n', '<C-k>', '<cmd>NavigatorUp<CR>', opts)
