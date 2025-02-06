vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
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
      vim.opt_local.expandtab = expandtab or true
    end,
  })
end

set_indent_for_filetype("lua", 2)
set_indent_for_filetype("javascript", 2)
set_indent_for_filetype("typescript", 2)
set_indent_for_filetype("svelte", 2)
set_indent_for_filetype("css", 2)
