vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Disable line wrapping
vim.opt.wrap = false

local function set_indent_for_filetype(
  filetype,
  indent_size,
  expandtab
)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = filetype,
    callback = function()
      vim.opt_local.tabstop = indent_size
      vim.opt_local.shiftwidth = indent_size
      vim.opt_local.softtabstop = indent_size
      vim.opt_local.expandtab = expandtab == nil or expandtab
    end,
  })
end

-- 2-space indentation
set_indent_for_filetype("lua", 2)

-- Tab indentation
set_indent_for_filetype("templ", 4, false)
set_indent_for_filetype("go", 4, false)
