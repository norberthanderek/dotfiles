local function config()
  local gitsigns = require("gitsigns")

  gitsigns.setup({
    attach_to_untracked = true,
    current_line_blame = true,
    current_line_blame_opts = {
      delay = 0,
    },
  })

  vim.cmd([[set statusline+=%{get(b:,'gitsigns_status','')}]])

  local keymap_opts = { remap = true, silent = true }

  -- git navigation
  vim.keymap.set("n", "]c", function()
    if vim.wo.diff then
      vim.cmd.normal({ "]c", bang = true })
    else
      gitsigns.nav_hunk("next")
    end
  end, keymap_opts)

  vim.keymap.set("n", "[c", function()
    if vim.wo.diff then
      vim.cmd.normal({ "[c", bang = true })
    else
      gitsigns.nav_hunk("prev")
    end
  end, keymap_opts)

  vim.keymap.set({'o', 'x'}, 'ih', gitsigns.select_hunk, keymap_opts)

  -- git actions
  vim.keymap.set("n", "<leader>bl", gitsigns.blame_line, keymap_opts)
  vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, keymap_opts)

  -- -- gitsigns.stage actually means "git add"
  vim.keymap.set("n", "<leader>ha", gitsigns.stage_hunk, keymap_opts)
  vim.keymap.set("v", "<leader>ha", function()
    gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, keymap_opts)
  vim.keymap.set("n", "<leader>ba", gitsigns.stage_buffer, keymap_opts)

  -- -- gitsigns.undo_stage actually means "git reset", it unstages changes
  vim.keymap.set("n", "<leader>hr", gitsigns.undo_stage_hunk, keymap_opts)

  -- -- gitsigns.reset actually means "git checkout", it reverts unstaged changes
  vim.keymap.set("n", "<leader>hc", gitsigns.reset_hunk, keymap_opts)
  vim.keymap.set("v", "<leader>hc", function()
    gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, keymap_opts)
  vim.keymap.set("n", "<leader>bc", gitsigns.reset_buffer, keymap_opts)
end

return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      config()
    end,
  },
}
