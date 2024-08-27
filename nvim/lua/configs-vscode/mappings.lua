local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Remap `Ctrl+[ and Ctrl+]` to move between tabs in VS Code
map('n', '<C-[>', ':<C-u>call VSCodeNotify("workbench.action.previousEditor")<CR>', opts)
map('n', '<C-]>', ':<C-u>call VSCodeNotify("workbench.action.nextEditor")<CR>', opts)