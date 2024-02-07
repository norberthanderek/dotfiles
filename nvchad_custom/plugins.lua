local plugins = {
    {
        "pocco81/auto-save.nvim",
        lazy = false,
        enabled = true,
    },
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "VeryLazy",
        opts = function()
            return require "custom.configs.null-ls"
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "plugins.configs.lspconfig"
            require "custom.configs.lspconfig"
        end,
    },
    -- overwrite
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                -- lua
                "lua-language-server",
                "stylua",

                -- web dev 
                "html",
                "css",
                "javascript",
                "typescript",
                "tsx",
                "json",

                -- cpp 
                "clang-format",
                "clangd",
                -- python
                "pyright",
                "black",
                -- rust
                "rust-analyzer"
            },
        },
    }
    -- Tresitter ensure installed ToDo
}

return plugins
