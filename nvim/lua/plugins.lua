local plugins = {
  --[[
        LSP
  ]]
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
    },
    config = function()
      require("configs.plugins.lspconfig")
    end,
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("configs.plugins.mason")
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("configs.plugins.lspconfig-mason")
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("configs.plugins.mason-tool-installer")
    end,
  },
  {
    "nvimdev/guard.nvim",
    dependencies = {
      "nvimdev/guard-collection",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      require("configs.plugins.guard")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("configs.plugins.treesitter")
    end,
  },
  {
    "nvim-treesitter/playground",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  --[[
        Navigation
  ]]
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("configs.plugins.nvim-tree")
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("configs.plugins.telescope")
    end,
  },
  --[[
        Theming
  ]]
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("configs.plugins.lualine")
    end,
  },
  {
    "utilyre/barbecue.nvim",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("configs.plugins.barbecue")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("configs.plugins.gitsigns")
    end,
  },
  {
    "uga-rosa/ccc.nvim",
    config = function()
      require("configs.plugins.ccc")
    end,
  },
  {
    "catppuccin/nvim",
    priority = 1000,
    config = function()
      require("configs.plugins.catppuccin")
    end,
  },
  --[[
        Helpers
  ]]
  {
    "pocco81/auto-save.nvim",
  },
  --[[
        AI / Completion
  ]]
  {
    "github/copilot.vim",
  },
  {
    "saghen/blink.cmp",
    version = "v0.*",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = {
      keymap = { preset = "default" },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
    },
  },
}

return plugins
