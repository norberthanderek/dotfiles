local function config()
  local ft = require("guard.filetype")

  local function is_executable(cmd)
    return vim.fn.executable(cmd) == 1
  end

  -- C & C++
  if is_executable("clang-format") and is_executable("clang-tidy") then
    ft("cpp,hpp,h,c"):fmt({
      cmd = "clang-format",
      args = { "--assume-filename=%:p" },
      stdin = true,
    }):lint({
      cmd = "clang-tidy",
      args = { "--quiet", "--", "%:p" },
      stdin = false,
    })
  end

  -- Rust
  if is_executable("rustfmt") and is_executable("cargo") then
    ft("rust"):fmt({
      cmd = "rustfmt",
      args = { "--emit=stdout", "--edition=2021" },
      stdin = true,
    }):lint({
      cmd = "cargo",
      args = { "clippy", "--message-format=json" },
      stdin = false,
    })
  end

  -- Python
  if is_executable("black") and is_executable("flake8") then
    ft("python"):fmt({
      cmd = "black",
      args = { "--fast", "-" },
      stdin = true,
    }):lint({
      cmd = "flake8",
      args = { "--stdin-display-name", "%:p", "-" },
      stdin = true,
    })
  end

  -- Lua
  if is_executable("stylua") and is_executable("luacheck") then
    ft("lua"):fmt({
      cmd = "stylua",
      args = { "-" },
      stdin = true,
    }):lint({
      cmd = "luacheck",
      args = { "--formatter", "plain", "--codes", "-" },
      stdin = true,
    })
  end

  -- C#
  if is_executable("dotnet") then
    ft("cs"):fmt({
      cmd = "dotnet",
      args = { "format", "--check", "%:p" },
      stdin = false,
    }):lint({
      cmd = "dotnet",
      args = { "format", "--check", "%:p" },
      stdin = false,
    })
  end

  -- Docker
  if is_executable("docker") then
    ft("dockerfile"):fmt({
      cmd = "docker",
      args = { "run", "--rm", "hadolint/hadolint", "hadolint", "--no-fail", "-" },
      stdin = true,
    })
  end

  -- Shell
  if is_executable("shfmt") and is_executable("shellcheck") then
    ft("sh,zsh"):fmt({
      cmd = "shfmt",
      args = { "-i", "2" },
      stdin = true,
    }):lint({
      cmd = "shellcheck",
      args = { "--format", "json", "-" },
      stdin = true,
    })
  end

  if is_executable("prettier") then
    -- JavaScript & TypeScript
    if is_executable("eslint") then
      ft("javascript,typescript"):fmt({
        cmd = "prettier",
        args = { "--stdin-filepath", "%:p" },
        stdin = true,
      }):lint({
        cmd = "eslint",
        args = { "--stdin-filename", "%:p", "--format", "json" },
        stdin = true,
      })
    end
    -- Markup
    ft("html"):fmt({
      cmd = "prettier",
      args = { "--stdin-filepath", "%:p" },
      stdin = true,
    })
    ft("css,scss"):fmt({
      cmd = "prettier",
      args = { "--stdin-filepath", "%:p" },
      stdin = true,
    })
    -- Markdown
    ft("markdown"):fmt({
      cmd = "prettier",
      args = { "--stdin-filepath", "%:p" },
      stdin = true,
    })
    ft("yaml,yml"):fmt({
      cmd = "prettier",
      args = { "--stdin-filepath", "%:p" },
      stdin = true,
    })
    -- JSON
    if is_executable("jq") then
      ft("json"):fmt({
        cmd = "prettier",
        args = { "--stdin-filepath", "%:p" },
        stdin = true,
      }):lint({
        cmd = "jq",
        args = { "." },
        stdin = true,
      })
    end
  end

  vim.g.guard_config = {
    fmt_on_save = false,
  }

  local keymap_opts = { noremap = true, silent = true }
  vim.keymap.set("n", "<leader>fm", ":Guard fmt<CR>", keymap_opts)
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
