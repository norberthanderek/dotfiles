local ft = require("guard.filetype")

-- C++
ft("cpp,hpp,h,c"):fmt({
	cmd = "clang-format",
	args = { "--assume-filename=%:p" },
	stdin = true,
}):lint({
	cmd = "clang-tidy",
	args = { "--quiet", "--", "%:p" },
	stdin = false,
})

-- Rust
ft("rust"):fmt({
	cmd = "rustfmt",
	args = { "--emit=stdout" },
	stdin = true,
}):lint({
	cmd = "cargo",
	args = { "clippy", "--message-format=json" },
	stdin = false,
})

-- Python
ft("python"):fmt({
	cmd = "black",
	args = { "--fast", "-" },
	stdin = true,
}):lint({
	cmd = "flake8",
	args = { "--stdin-display-name", "%:p", "-" },
	stdin = true,
})

-- Lua
ft("lua"):fmt({
	cmd = "stylua",
	args = { "-" },
	stdin = true,
}):lint({
	cmd = "luacheck",
	args = { "--formatter", "plain", "--codes", "-" },
	stdin = true,
})

vim.g.guard_config = {
  fmt_on_save = false,
}

local keymap_opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>fm", ":GuardFmt<CR>", keymap_opts)
