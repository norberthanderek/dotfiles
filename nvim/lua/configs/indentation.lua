vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

local function set_indent_for_filetype(filetype, indent_size)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = filetype,
    callback = function()
      vim.opt_local.tabstop = indent_size
      vim.opt_local.shiftwidth = indent_size
    end,
  })
end

set_indent_for_filetype("lua", 2)
set_indent_for_filetype("javascript", 2)
set_indent_for_filetype("typescript", 2)
set_indent_for_filetype("json", 2)