local bufferline = require("bufferline")

bufferline.setup({
  options = {
    close_command = "bp|sp|bn|bd",
    left_mouse_command = "buffer %d",
    middle_mouse_command = "",
    right_mouse_command = "",
    numbers = "none",
    name_formatter = function(buf)
      if buf.name:match("%.md") then
        return vim.fn.fnamemodify(buf.name, ":t:r")
      end
    end,
    max_name_length = 18,
    max_prefix_length = 15,
    tab_size = 18,
    offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "left" } },
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true,
    separator_style = "slant",
    always_show_bufferline = true,
    sort_by = "id",
  },
})

local keymap_opts = { remap = true, silent = true }

-- Map <leader>bp to toggle pin on buffer
vim.keymap.set("n", "<leader>bp", ":BufferLineTogglePin<CR>", keymap_opts)

-- Map <Tab> and <S-Tab> to cycle through buffers
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", keymap_opts)
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", keymap_opts)

-- Map <leader>bn and <leader>bm to move buffers
vim.keymap.set("n", "<leader>bl", ":BufferLineMoveNext<CR>", keymap_opts)
vim.keymap.set("n", "<leader>bh", ":BufferLineMovePrev<CR>", keymap_opts)

-- Map <leader>x to close buffer and go to next one
vim.keymap.set("n", "<leader>x", ":bp|sp|bn|bd<CR>", keymap_opts)
