local mason_installer = require('mason-tool-installer')

mason_installer.setup({
  ensure_installed = {
    -- "black",         install globally
    -- "clang-format",  install globally
    "eslint",
    -- "flake8",        install globally
    "luacheck",
    "prettier",
    -- "rustfmt",       install globally via rustup
    "stylelint",
    "stylua",
  },
  auto_update = true,
  run_on_start = true,
})