local function config()
  local lspconfig = require("lspconfig")

  local servers = {
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
  }

  for _, server in ipairs(servers) do
    lspconfig[server].setup({
      on_attach = function(client, bufnr)
        -- Use LSP-based formatting when available
        if client.server_capabilities.documentFormattingProvider then
          vim.api.nvim_set_option_value("formatexpr", "v:lua.vim.lsp.formatexpr()", { buf = bufnr })
        end
      end,
      capabilities = require("blink.cmp").get_lsp_capabilities(),
    })
  end

  -- Keymaps
  local keymap_opts = { remap = true, silent = true }
  vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, keymap_opts)
  vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, keymap_opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, keymap_opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, keymap_opts)
  vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, keymap_opts)

end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
    },
    config = function()
      config()
    end,
  },
}
