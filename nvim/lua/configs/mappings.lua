local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Remap `Ctrl+Shift+[` and `...+]` to move between tabs in VS Code
map('n', '<C-S-[>', ':call VSCodeNotify("workbench.action.previousEditor")<CR>', opts)
map('n', '<C-S-]>', ':call VSCodeNotify("workbench.action.nextEditor")<CR>', opts)
