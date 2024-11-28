local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
  ensure_installed = {
    "clangd", -- C/C++
    "rust_analyzer", -- Rust
    "pyright", -- Python
    "lua_ls", -- Lua
  },
})
