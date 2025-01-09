local function config()
  local telescope = require("telescope")

  telescope.setup({
    defaults = {
      prompt_prefix = "   ",
      selection_caret = " ",
      entry_prefix = " ",
      sorting_strategy = "ascending",
      path_display = {
        truncate = 3,
      },
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
        },
        width = 0.95,
        height = 0.90,
      },
      mappings = {
        n = { ["q"] = require("telescope.actions").close },
      },
    },
    extensions_list = { "themes", "terms" },
    extensions = {},
  })

  -- Keymaps
  local keymap_opts = { noremap = true, silent = true }
  local builtin = require("telescope.builtin")

  vim.keymap.set("n", "<leader>ff", builtin.find_files, keymap_opts)
  vim.keymap.set("n", "<leader>fg", builtin.live_grep, keymap_opts)
  vim.keymap.set("n", "<leader>fb", builtin.buffers, keymap_opts)
  vim.keymap.set("n", "<leader>fn", builtin.help_tags, keymap_opts)
  vim.keymap.set("n", "<leader>gs", builtin.git_status, keymap_opts)
end

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      config()
    end,
  },
}
