local remap_opts = { remap = true, silent = true }

-- Remap commenting
vim.keymap.set("n", "<C-/>", "gcc", remap_opts)
vim.keymap.set("v", "<C-/>", "gc", remap_opts)
