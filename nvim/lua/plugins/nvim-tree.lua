local function config()
  local nvim_tree = require("nvim-tree")

  nvim_tree.setup({
    disable_netrw = true,
    hijack_cursor = true,
    sync_root_with_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = false,
    },
    filters = { dotfiles = false },
    git = {
      ignore = false,
    },
    view = {
      width = 30,
      adaptive_size = true,
      preserve_window_proportions = true,
    },
    renderer = {
      root_folder_label = false,
      highlight_git = true,
      indent_markers = { enable = false },
      icons = {
        glyphs = {
          default = "󰈚",
          folder = {
            default = "",
            empty = "",
            empty_open = "",
            open = "",
            symlink = "",
          },
          git = {
            unstaged = "◇",
            staged = "◆",
            unmerged = "",
            renamed = "→",
            untracked = "△",
            deleted = "-",
            ignored = " ",
          },
        },
        git_placement = "after",
      },
    },
  })

  local keymap_opts = { noremap = true, silent = true }
  vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", keymap_opts)
end

return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      config()
    end,
  },
}
