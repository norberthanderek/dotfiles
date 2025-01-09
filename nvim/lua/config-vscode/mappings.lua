local keymap_opts = { noremap = true, silent = true }

-- Reload neovim config
vim.keymap.set("n", "<leader>rc", ":source ~/.config/nvim/init.lua <CR>", keymap_opts)

-- Remap Tab and Shift+Tab to move between tabs in VS Code
vim.keymap.set("n", "<Tab>", ':call VSCodeNotify("workbench.action.nextEditor")<CR>', keymap_opts)
vim.keymap.set("n", "<S-Tab>", ':call VSCodeNotify("workbench.action.previousEditor")<CR>', keymap_opts)
