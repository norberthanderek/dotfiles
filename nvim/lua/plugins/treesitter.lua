local function config()
  local tree_sitter = require("nvim-treesitter")
  local languages = {
    "bash",
    "c",
    "cmake",
    "cpp",
    "css",
    "dockerfile",
    "gitcommit",
    "go",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "rust",
    "svelte",
    "toml",
    "typescript",
    "vim",
    "yaml",
  }

  tree_sitter.setup({
    install_dir = vim.fn.stdpath("data") .. "/site",
  })

  tree_sitter.install(languages)

  vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
      pcall(vim.treesitter.start, args.buf)
    end,
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
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      config()
    end,
  },
}
