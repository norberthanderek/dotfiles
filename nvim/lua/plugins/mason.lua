local function config()
  local mason = require("mason")
  local path_sep = package.config:sub(1, 1) == "\\" and ";" or ":"
  local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"

  vim.env.PATH = mason_bin .. path_sep .. vim.env.PATH

  mason.setup({
    install_root_dir = vim.fn.stdpath("data") .. "/mason",
    pip = {
      install_args = { "--user", "--upgrade" },
    },
    log_level = vim.log.levels.INFO,
  })
end

return {
  {
    "williamboman/mason.nvim",
    config = function()
      config()
    end,
  },
}
