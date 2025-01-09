local function config()
  local tree_sitter = require("nvim-treesitter.configs")

  tree_sitter.setup({
    ensure_installed = {
      "c",
      "cpp",
      "rust",
      "python",
      "html",
      "css",
      "javascript",
      "typescript",
      "svelte",
      "json",
      "yaml",
      "toml",
      "go",
      "lua",
      "vim",
      "cmake",
      "dockerfile",
      "bash",
    },
    ignore_install = {},
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
    modules = {},
  })

  vim.filetype.add({
    extension = {
      zsh = "sh",
      sh = "sh",
    },
  })
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      config()
    end,
  },
  {
    "nvim-treesitter/playground",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
