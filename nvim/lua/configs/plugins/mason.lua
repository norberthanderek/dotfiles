local mason = require("mason")

vim.env.PATH = vim.fn.expand("~/.local/share/nvim/mason/bin") .. ":" .. vim.env.PATH

mason.setup({
    install_root_dir = vim.fn.stdpath("data") .. "/mason",
    pip = {
        install_args = { "--user", "--upgrade" },
    },
    npm = {
        -- Change the install command from npm to bun
        install_command = "bun",
        install_args = { "add", "-g" },
        update_command = "bun",
        update_args = { "upgrade" },
    },
    log_level = vim.log.levels.INFO,
})