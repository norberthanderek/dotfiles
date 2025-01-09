local function config()
  local lspconfig = require("lspconfig")

  local servers = {
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

  -- Overrides
  lspconfig.lua_ls.setup({
    on_init = function(client)
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
          return
        end
      end

      client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
        runtime = {
          version = "LuaJIT",
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = true,
          library = vim.api.nvim_get_runtime_file("", true),
        },
      })
    end,
    settings = {
      Lua = {},
    },
  })
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
