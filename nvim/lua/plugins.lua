local plugins = {
	{
		"neovim/nvim-lspconfig",
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
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup()
		end,
	},
	{
		"pocco81/auto-save.nvim",
	},
}

return plugins
