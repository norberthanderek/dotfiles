local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
  automatic_installation = true,
  ensure_installed = {
    "clangd", -- C/C++
    "rust_analyzer", -- Rust
    "pyright", -- Python
    "lua_ls", -- Lua
    "svelte", -- Svelte
    "ts_ls", -- TypeScript
    "omnisharp", -- C#
    "dockerls", -- Docker
    "html", -- HTML
    "cssls", -- CSS
    "jsonls", -- JSON
    "yamlls", -- YAML
    "bashls", -- Bash
    "sqlls", -- SQL
  },
})
