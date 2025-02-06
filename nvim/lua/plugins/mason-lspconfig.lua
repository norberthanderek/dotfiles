local function config()
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
      "gopls", -- GO
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
end

return {
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      config()
    end,
  },
}
