local lspconfig = require('lspconfig')

local servers = { "clangd", "rust_analyzer", "pyright", "tsserver", "lua_ls" }

for _, server in ipairs(servers) do
  lspconfig[server].setup {
    on_attach = function(client, bufnr)
      -- Example: Use LSP-based formatting when available
      if client.server_capabilities.documentFormattingProvider then
          vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')
      end
    end
  }
end
