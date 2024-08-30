local ft = require("guard.filetype")

-- C++
ft("cpp,hpp,h,c")
    :fmt({
        cmd = "clang-format",
        args = {"--assume-filename=%:p"},
        stdin = true
    })
    :lint({
        cmd = "clang-tidy",
        args = {"--quiet", "--", "%:p"},
        stdin = false
    })

-- Rust
ft("rust")
    :fmt({
        cmd = "rustfmt",
        args = {"--emit=stdout"},
        stdin = true
    })
    :lint({
        cmd = "cargo",
        args = {"clippy", "--message-format=json"},
        stdin = false
    })

-- Python
ft("python")
    :fmt({
        cmd = "black",
        args = {"--fast", "-"},
        stdin = true
    })
    :lint({
        cmd = "flake8",
        args = {"--stdin-display-name", "%:p", "-"},
        stdin = true
    })

-- Lua
ft("lua")
    :fmt({
        cmd = "stylua",
        args = {"-"},
        stdin = true
    })
    :lint({
        cmd = "luacheck",
        args = {"--formatter", "plain", "--codes", "-"},
        stdin = true
    })

-- Svelte
ft("svelte")
    :fmt({
        cmd = "prettier",
        args = {"--stdin-filepath", "%:p"},
        stdin = true
    })
    :lint({
        cmd = "vscode-eslint-language-server",
        args = {"--stdin", "--stdin-filename", "%:p"},
        stdin = true
    })

-- TypeScript
ft("typescript")
    :fmt({
        cmd = "prettier",
        args = {"--stdin-filepath", "%:p"},
        stdin = true
    })
    :lint({
        cmd = "vscode-eslint-language-server",
        args = {"--stdin", "--stdin-filename", "%:p"},
        stdin = true
    })

-- JavaScript
ft("javascript")
    :fmt({
        cmd = "prettier",
        args = {"--stdin-filepath", "%:p"},
        stdin = true
    })
    :lint({
        cmd = "vscode-eslint-language-server",
        args = {"--stdin", "--stdin-filename", "%:p"},
        stdin = true
    })

-- HTML
ft("html")
    :fmt({
        cmd = "prettier",
        args = {"--stdin-filepath", "%:p"},
        stdin = true
    })
    :lint({
        cmd = "vscode-eslint-language-server",
        args = {"--stdin", "--stdin-filename", "%:p"},
        stdin = true
    })

-- CSS
ft("css")
    :fmt({
        cmd = "prettier",
        args = {"--stdin-filepath", "%:p"},
        stdin = true
    })
    :lint({
        cmd = "stylelint",
        args = {"--stdin", "--stdin-filename", "%:p"},
        stdin = true
    })

-- call setup LAST
require("guard").setup({
    fmt_on_save = true,
})