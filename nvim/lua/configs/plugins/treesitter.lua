local tree_sitter = require("nvim-treesitter.configs")

tree_sitter.setup({
  ensure_installed = {
    "cpp",
    "c",
    "rust",
    "python",
    "lua",
    "vim",
  },
  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
})
