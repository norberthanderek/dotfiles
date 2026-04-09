local function config()
  local ft = require("guard.filetype")
  local mason_profiles = require("config.mason_profiles")
  local formatter_requirements = {}
  local warned_buffers = {}

  local function is_executable(cmd)
    return vim.fn.executable(cmd) == 1
  end

  local function register_format(filetypes, required_commands, formatter)
    if type(filetypes) == "string" then
      filetypes = vim.split(filetypes, ",", { trimempty = true })
    end

    for _, filetype in ipairs(filetypes) do
      formatter_requirements[filetype] = required_commands
    end

    if vim.iter(required_commands):all(is_executable) then
      ft(table.concat(filetypes, ",")):fmt(formatter)
    end
  end

  local function register_lint(filetypes, required_commands, linter)
    if type(filetypes) == "string" then
      filetypes = vim.split(filetypes, ",", { trimempty = true })
    end

    if vim.iter(required_commands):all(is_executable) then
      ft(table.concat(filetypes, ",")):lint(linter)
    end
  end

  local function missing_commands(commands)
    local missing = {}

    for _, cmd in ipairs(commands) do
      if not is_executable(cmd) then
        table.insert(missing, cmd)
      end
    end

    return missing
  end

  local function notify_missing_formatter()
    local filetype = vim.bo.filetype
    local requirements = formatter_requirements[filetype]

    if not requirements then
      return false
    end

    local missing = missing_commands(requirements)
    if #missing == 0 then
      return false
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local cache_key = table.concat({ bufnr, filetype, table.concat(missing, ",") }, ":")
    if warned_buffers[cache_key] then
      return true
    end

    warned_buffers[cache_key] = true
    vim.notify(
      string.format("Guard formatter for '%s' is unavailable. Missing: %s", filetype, table.concat(missing, ", ")),
      vim.log.levels.WARN
    )

    return true
  end

  local function guard_fmt()
    if notify_missing_formatter() then
      return
    end

    vim.cmd("Guard fmt")
  end

  if mason_profiles.is_enabled("core") then
    register_format({ "cpp", "hpp", "h", "c" }, { "clang-format" }, {
      cmd = "clang-format",
    })
    register_lint({ "cpp", "hpp", "h", "c" }, { "clang-tidy" }, {
      cmd = "clang-tidy",
      args = { "--quiet", "--", "%:p" },
      stdin = false,
    })

    register_format({ "rust" }, { "rustfmt" }, {
      cmd = "rustfmt",
      args = { "--emit=stdout", "--edition=2021" },
      stdin = true,
    })
    register_lint({ "rust" }, { "cargo" }, {
      cmd = "cargo",
      args = { "clippy", "--message-format=json" },
      stdin = false,
    })

    register_format({ "lua" }, { "stylua" }, {
      cmd = "stylua",
      args = { "-" },
      stdin = true,
    })

    register_format({ "markdown" }, { "prettier" }, "prettier")
  end

  if mason_profiles.is_enabled("python") then
    register_format({ "python" }, { "black" }, {
      cmd = "black",
      args = { "--fast", "-" },
      stdin = true,
    })
    register_lint({ "python" }, { "flake8" }, {
      cmd = "flake8",
      args = { "--stdin-display-name", "%:p", "-" },
      stdin = true,
    })
  end

  if mason_profiles.is_enabled("lua") then
    register_lint({ "lua" }, { "luacheck" }, {
      cmd = "luacheck",
      args = { "--formatter", "plain", "--codes", "-" },
      stdin = true,
    })
  end

  if mason_profiles.is_enabled("dotnet") then
    register_format({ "cs" }, { "dotnet" }, {
      cmd = "dotnet",
      args = { "format", "--check", "%:p" },
      stdin = false,
    })
    register_lint({ "cs" }, { "dotnet" }, {
      cmd = "dotnet",
      args = { "format", "--check", "%:p" },
      stdin = false,
    })
  end

  if mason_profiles.is_enabled("infra") then
    register_format({ "dockerfile" }, { "docker" }, {
      cmd = "docker",
      args = { "run", "--rm", "hadolint/hadolint", "hadolint", "--no-fail", "-" },
      stdin = true,
    })

    register_format({ "sh", "zsh" }, { "shfmt" }, {
      cmd = "shfmt",
      args = { "-i", "4" },
      stdin = true,
    })

  end

  if mason_profiles.is_enabled("web") then
    register_format({ "javascript", "typescript", "svelte", "html", "css", "scss", "yaml", "yml", "json" }, { "prettier" }, "prettier")
  end

  if mason_profiles.is_enabled("go") then
    register_format({ "go" }, { "gofmt" }, {
      cmd = "gofmt",
      args = { "-s" },
      stdin = true,
    })
  end

  vim.g.guard_config = {
    fmt_on_save = false,
  }

  local keymap_opts = { noremap = true, silent = true }
  vim.keymap.set("n", "<leader>fm", guard_fmt, keymap_opts)
end

return {
  {
    "nvimdev/guard.nvim",
    dependencies = {
      "nvimdev/guard-collection",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      config()
    end,
  },
}
