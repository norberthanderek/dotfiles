local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
  automatic_installation = true,
  ensure_installed = {
    "clangd", -- C/C++
    "rust_analyzer", -- Rust
    "pyright", -- Python
    "lua_ls", -- Lua
  },
})
