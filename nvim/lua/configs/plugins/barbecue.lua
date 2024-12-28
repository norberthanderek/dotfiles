local barbecue = require("barbecue")

barbecue.setup({
  create_autocmd = false,
  show_modified = true,
})

vim.api.nvim_create_autocmd({
  "WinResized",
  "BufWinEnter",
  "CursorMoved",
  "InsertLeave",
  "BufModifiedSet",
}, {
  group = vim.api.nvim_create_augroup("barbecue.updater", {}),
  callback = function()
    require("barbecue.ui").update()
  end,
})
