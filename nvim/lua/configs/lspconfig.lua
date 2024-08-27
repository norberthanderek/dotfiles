local lspconfig = require "lspconfig"

lspconfig.clangd.setup{
  cmd = {
    "clangd",
    "--background-index",
    "--suggest-missing-includes",
    "--header-insertion=never",
    "--clang-tidy",
  },
}
