local M = {}

function M.setup()
  vim.wo.number = true
  vim.wo.signcolumn = "yes"

  vim.opt.list = true
  vim.opt.listchars = "tab:→ ,eol:↲,space:•,trail:~,extends:⟩,precedes:⟨"
  vim.opt.showbreak = "↪"

  vim.opt.background = "dark"
  vim.opt.termguicolors = true
end

return M
