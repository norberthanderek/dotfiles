local function config()
  local mason_installer = require("mason-tool-installer")
  local mason_profiles = require("config.mason_profiles")

  mason_installer.setup({
    ensure_installed = mason_profiles.ensure_installed("tools"),
    auto_update = true,
    run_on_start = true,
  })
end

return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      config()
    end,
  },
}
