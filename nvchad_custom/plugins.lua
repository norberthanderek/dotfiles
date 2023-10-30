local plugins = {
    {
        "pocco81/auto-save.nvim",
        lazy = false,
        enabled = true
    },
    {
        "christoomey/vim-tmux-navigator", lazy = false
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "plugins.configs.lspconfig"
            require "custom.configs.lspconfig"
        end
    },
    -- overwrite
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "lua-ls",
                "html-lsp",
                "prettier",
                "stylua",
                "clang-format",
                "clangd",
                "pyright",
                "rust-analyzer"
            },
        },
    }
}

return plugins