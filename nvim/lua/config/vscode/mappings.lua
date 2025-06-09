local keymap_opts = { noremap = true, silent = true }

-- Remap Tab and Shift+Tab to move between tabs in VS Code
vim.keymap.set("n", "<Tab>", ':call VSCodeNotify("workbench.action.nextEditor")<CR>', keymap_opts)
vim.keymap.set("n", "<S-Tab>", ':call VSCodeNotify("workbench.action.previousEditor")<CR>', keymap_opts)

-- Format document
vim.keymap.set("n", "<leader>fm", ':call VSCodeNotify("editor.action.formatDocument")<CR>', keymap_opts)

-- File explorer
vim.keymap.set("n", "<leader>fe", ':call VSCodeNotify("workbench.view.explorer")<CR>', keymap_opts)

-- Telescope mimic
vim.keymap.set("n", "<leader>ff", ':call VSCodeNotify("workbench.action.quickOpen")<CR>', keymap_opts)
vim.keymap.set("n", "<leader>fg", ':call VSCodeNotify("workbench.action.findInFiles")<CR>', keymap_opts)
vim.keymap.set("n", "<leader>fb", ':call VSCodeNotify("workbench.action.showAllEditors")<CR>', keymap_opts)
