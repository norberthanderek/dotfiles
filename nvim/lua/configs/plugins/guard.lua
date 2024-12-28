local ft = require("guard.filetype")

-- C++
ft("cpp,hpp,h,c"):fmt({
  cmd = "clang-format",
}):lint({
  cmd = "clang-tidy",
})

-- Rust
ft("rust"):fmt({
  cmd = "rustfmt",
}):lint({
  cmd = "cargo",
})

-- Python
ft("python"):fmt({
  cmd = "black",
}):lint({
  cmd = "flake8",
})

-- Lua
ft("lua"):fmt({
  cmd = "stylua",
}):lint({
  cmd = "luacheck",
})

vim.g.guard_config = {
  fmt_on_save = false,
}

local keymap_opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>fm", ":Guard fmt<CR>", keymap_opts)
