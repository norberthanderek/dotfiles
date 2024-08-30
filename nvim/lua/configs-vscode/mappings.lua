local keymap_opts = { noremap = true, silent = true }

-- Remap `Ctrl+Shift+[` and `...+]` to move between tabs in VS Code
vim.keymap.set("n", "<C-S-[>", ':call VSCodeNotify("workbench.action.previousEditor")<CR>', keymap_opts)
vim.keymap.set("n", "<C-S-]>", ':call VSCodeNotify("workbench.action.nextEditor")<CR>', keymap_opts)
