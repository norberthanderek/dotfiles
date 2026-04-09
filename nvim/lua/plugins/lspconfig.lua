local function config()
  local mason_profiles = require("config.mason_profiles")
  local servers = mason_profiles.ensure_installed("lsp")
  local capabilities = require("blink.cmp").get_lsp_capabilities()

  for _, server in ipairs(servers) do
    vim.lsp.config(server, {
      capabilities = capabilities,
    })
    vim.lsp.enable(server)
  end

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      local bufnr = args.buf

      if client and client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_set_option_value("formatexpr", "v:lua.vim.lsp.formatexpr()", { buf = bufnr })
      end

      local keymap_opts = { remap = true, silent = true, buffer = bufnr }
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, keymap_opts)
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, keymap_opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, keymap_opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, keymap_opts)
      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, keymap_opts)
    end,
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
