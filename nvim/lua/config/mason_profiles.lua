local M = {}

local profiles = {
  core = {
    lsp = {
      "lua_ls",
      "clangd",
      "rust_analyzer",
    },
    tools = {
      "stylua",
      "codelldb",
      "prettier",

    },
  },
  python = {
    lsp = {
      "pyright",
    },
    tools = {
    },
  },
  web = {
    lsp = {
      "ts_ls",
      "svelte",
      "html",
      "cssls",
      "jsonls",
    },
    tools = {},
  },
  infra = {
    lsp = {
      "yamlls",
      "bashls",
      "dockerls",
    },
    tools = {
      "shfmt",
    },
  },
  go = {
    lsp = {
      "gopls",
    },
    tools = {},
  },
  lua = {
    lsp = {},
    tools = {
      "luacheck",
    },
  },
  data = {
    lsp = {
      "sqlls",
    },
    tools = {},
  },
  dotnet = {
    lsp = {
      "omnisharp",
    },
    tools = {},
  },
}

local defaults = {
  enabled_profiles = {
    "core",
    "python",
    "infra",
  },
  extra_lsp = {},
  extra_tools = {},
}

local function unique(items)
  local seen = {}
  local result = {}

  for _, item in ipairs(items) do
    if item and not seen[item] then
      seen[item] = true
      table.insert(result, item)
    end
  end

  return result
end

local function read_local_config()
  local ok, local_config = pcall(require, "config.local.mason")
  if ok and type(local_config) == "table" then
    return local_config
  end

  return {}
end

local function merge_lists(base, extra)
  local result = vim.deepcopy(base)

  if type(extra) == "table" then
    vim.list_extend(result, extra)
  end

  return result
end

function M.profiles()
  return profiles
end

function M.selection()
  local local_config = read_local_config()

  return {
    enabled_profiles = merge_lists(defaults.enabled_profiles, local_config.enabled_profiles),
    extra_lsp = merge_lists(defaults.extra_lsp, local_config.extra_lsp),
    extra_tools = merge_lists(defaults.extra_tools, local_config.extra_tools),
  }
end

function M.is_enabled(profile_name)
  local selection = M.selection()

  for _, enabled_profile in ipairs(selection.enabled_profiles) do
    if enabled_profile == profile_name then
      return true
    end
  end

  return false
end

function M.ensure_installed(kind)
  local selection = M.selection()
  local items = {}

  for _, profile_name in ipairs(selection.enabled_profiles) do
    local profile = profiles[profile_name]
    if profile and profile[kind] then
      vim.list_extend(items, profile[kind])
    end
  end

  if kind == "lsp" then
    vim.list_extend(items, selection.extra_lsp)
  elseif kind == "tools" then
    vim.list_extend(items, selection.extra_tools)
  end

  return unique(items)
end

return M
