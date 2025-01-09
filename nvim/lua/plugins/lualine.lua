local function config()
  local lualine = require("lualine")

  lualine.setup({
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      lualine_c = { "filename", "modified" },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename", "modified" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    extensions = { "fugitive", "nvim-tree" },
  })
end

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      config()
    end,
  },
}
