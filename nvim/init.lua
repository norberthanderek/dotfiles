-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Spacebar as the leader
vim.g.mapleader = " "

-- Check if running inside VS Code
local in_vscode = vim.fn.exists("g:vscode") == 1

if in_vscode then -- VS Code nvim config
  require("config-vscode.mappings")
else -- nvim config
  require("config.mappings")
  require("config.indentation")
  require("config.theme").setup()

  -- bootstrap lazy and all plugins
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

  if not vim.uv.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
  end

  vim.opt.rtp:prepend(lazypath)

  require("lazy").setup({
    spec = {
      { import = "plugins" },
    },
    change_detection = {
      enabled = false,
    },
  })
end

--[[
  Common config
]]

vim.schedule(function()
  require("common.mappings")
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

-- Time (ms) after which the CursorHold autocommand is triggered
vim.opt.updatetime = 750
