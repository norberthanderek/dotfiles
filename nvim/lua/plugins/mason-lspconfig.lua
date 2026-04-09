local function config()
  local mason_lspconfig = require("mason-lspconfig")
  local mason_profiles = require("config.mason_profiles")

  mason_lspconfig.setup({
    automatic_installation = true,
    ensure_installed = mason_profiles.ensure_installed("lsp"),
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
