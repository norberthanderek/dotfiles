-- Spacebar as the leader
vim.g.mapleader = " "

-- Check if running inside VS Code
local in_vscode = vim.fn.exists('g:vscode') == 1

if in_vscode then -- VS Code nvim config
  require('configs-vscode.mappings')

else -- nvim config
  -- bootstrap lazy and all plugins
  local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

  if not vim.uv.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
  end
  
  vim.opt.rtp:prepend(lazypath)

  local lazy_config = require "configs.lazy"

  -- load plugins
  require("lazy").setup({
    { import = "plugins" },
  }, lazy_config)
end

-- Common 
vim.schedule(function()
  require "common-mappings"
end)

vim.opt.clipboard = "unnamedplus"

-- Set undo history to 1000
vim.opt.undolevels = 1000
vim.opt.undoreload = 1000

-- Enable persistent undo
vim.opt.undofile = true
local undo_dir = vim.fn.expand("~/.local/share/nvim/undo")
vim.opt.undodir = undo_dir
vim.fn.mkdir(undo_dir, "p")

print "NeoVim configuration loaded successfully!"