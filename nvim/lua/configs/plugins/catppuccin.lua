local catppuccin = require("catppuccin")

-- Using catppuccin plugin as an engine and overwriting almost everything
catppuccin.setup({
  flavor = "mocha",
  custom_highlights = function(colors)
    return {
      -- General Text Editing
      Whitespace = { fg = colors.surface0 },
      NonText = { fg = colors.surface0 },
      -- Treesitter
      ["@keyword"] = { fg = colors.teal },
      ["@keyword.type"] = { fg = colors.teal },
      ["@keyword.import"] = { fg = colors.teal },
      ["@keyword.modifier"] = { fg = colors.teal },
      ["@keyword.function"] = { fg = colors.teal },
      ["@keyword.coroutine"] = { fg = colors.teal },
      ["@variable"] = { fg = colors.maroon },
      ["@variable.builtin"] = { fg = colors.teal },
      ["@variable.member"] = { fg = colors.peach },
      ["@variable.parameter"] = { fg = colors.mauve },
      ["@property"] = { fg = colors.peach },
      ["@function"] = { fg = colors.blue },
      ["@function.call"] = { fg = colors.blue },
      ["@type"] = { fg = colors.lavender },
      ["@type.builtin"] = { fg = colors.lavender },
      ["@string.special.path"] = { fg = colors.text },
      -- NvimTree
      NvimTreeNormal = { fg = colors.text, bg = colors.crust },
      NvimTreeEndOfBuffer = { fg = colors.crust },
      NvimTreeRootFolder = { fg = colors.text, bold = true },
      NvimTreeFolderName = { fg = colors.text },
      NvimTreeOpenedFolderName = { fg = colors.text },
      NvimTreeEmptyFolderName = { fg = colors.subtext1 },
      NvimTreeFolderIcon = { fg = colors.subtext1 },
      NvimTreeEmptyFolderIcon = { fg = colors.subtext1 },
      NvimTreeOpenedFile = { fg = colors.text },
      NvimTreeMarkdownFile = { fg = colors.text },
      NvimTreeImageFile = { fg = colors.text },
      NvimTreeExecFile = { fg = colors.yellow },
      NvimTreeSpecialFile = { fg = colors.rosewater },
      NvimTreeIndentMarker = { fg = colors.subtext1 },
      NvimTreeGitDirty = { fg = colors.blue },
      NvimTreeGitStaged = { fg = colors.teal },
      NvimTreeGitMerge = { fg = colors.peach },
      NvimTreeGitRenamed = { fg = colors.sky },
      NvimTreeGitNew = { fg = colors.green },
      NvimTreeGitDeleted = { fg = colors.maroon },
      NvimTreeGitIgnored = { fg = colors.overlay1 },
      NvimTreeSymlink = { fg = colors.peach },
      NvimTreeExecLink = { fg = colors.peach },
      -- Telescope
      TelescopeNormal = { fg = colors.text, bg = colors.mantle },
      TelescopeSelection = { fg = colors.text, bg = colors.surface0 },
      TelescopeBorder = { fg = colors.subtext1, bg = colors.mantle },
      TelescopePromptBorder = { fg = colors.surface0, bg = colors.mantle },
      TelescopeResultsBorder = { fg = colors.surface0, bg = colors.mantle },
      TelescopePreviewBorder = { fg = colors.overlay0, bg = colors.mantle },
      TelescopePromptPrefix = { fg = colors.text },
      TelescopePromptSelection = { fg = colors.text },
      TelescopePromptCounter = { fg = colors.surface2 },
      TelescopePreviewMatch = { fg = colors.blue },
      TelescopePromptMatch = { fg = colors.blue },
      TelescopeMatching = { fg = colors.blue },
      -- Gitsigns
      GitSignsAdd = { fg = colors.green },
      GitSignsChange = { fg = colors.blue },
      GitSignsDelete = { fg = colors.maroon },
      GitSignsChangeDelete = { fg = colors.maroon },
    }
  end,
  color_overrides = {
    mocha = {
      -- Background layers
      base = "#12141A",
      mantle = "#0E1014",
      crust = "#0a0b0e",
      -- Accents
      red = "#ff4462",
      maroon = "#F95F85",
      flamingo = "#FC8EAC",
      peach = "#FC9060",
      yellow = "#EED97A",
      rosewater = "#F5B8AB",
      mauve = "#E98EE1",
      pink = "#fa7af0",
      green = "#A0D370",
      teal = "#72DDBD",
      blue = "#77DCE7",
      sky = "#87CEEB",
      lavender = "#A596E8",
      sapphire = "#7280f8",
      -- Foregrounds / overlays
      text = "#C6CAD7",
      subtext1 = "#A9AEC1",
      subtext0 = "#8E94AB",
      overlay2 = "#7D8296",
      overlay1 = "#676B80",
      overlay0 = "#464957",
      -- Surface layers
      surface2 = "#3A3D4A",
      surface1 = "#2F313D",
      surface0 = "#1D1E29",
    },
  },

  integrations = {
    treesitter = true,
    nvimtree = true,
    telescope = true,
    gitsigns = true,
  },
})

vim.cmd([[colorscheme catppuccin]])
