local function config()
  local mason_installer = require("mason-tool-installer")

  mason_installer.setup({
    ensure_installed = {
      -- "black",         install globally
      -- "clang-format",  install globally
      -- "flake8",        install globally
      "codelldb",
      "luacheck",
      -- "rustfmt",       install globally via rustup
      "stylelint",
      "stylua",
    },
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
