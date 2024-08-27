local plugins = {
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "configs.lspconfig"
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "VeryLazy",
        opts = function()
            return require "configs.null-ls"
        end,
    },
    {
        "pocco81/auto-save.nvim",
        lazy = false,
        enabled = true,
    },
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
    },
}

return plugins
