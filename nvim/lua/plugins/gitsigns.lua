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

  -- Map ]g + [c to navigate through hunks
  vim.keymap.set("n", "]c", gitsigns.next_hunk, keymap_opts)
  vim.keymap.set("n", "[c", gitsigns.prev_hunk, keymap_opts)

  -- Map git blame, preview, reset, stage, and undo stage
  vim.keymap.set("n", "<leader>bl", gitsigns.blame_line, keymap_opts)
  vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, keymap_opts)
  vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk, keymap_opts)
  vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, keymap_opts)
  vim.keymap.set("n", "<leader>hus", gitsigns.undo_stage_hunk, keymap_opts)
end

return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      config()
    end,
  },
}
