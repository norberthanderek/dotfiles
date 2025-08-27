local remap_opts = { remap = true, silent = true }

-- Remap commenting
if require("utils.os").is_windows() then
  -- <C-_> means <C-/> on Windows Terminal ¯\_(ツ)_/¯
  vim.keymap.set("n", "<C-_>", "gcc", remap_opts)
  vim.keymap.set("v", "<C-_>", "gc", remap_opts)
else
  vim.keymap.set("n", "<C-/>", "gcc", remap_opts)
  vim.keymap.set("v", "<C-/>", "gc", remap_opts)
end
