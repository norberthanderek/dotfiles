# Neovim Local Config Directory

Populate it with local config files that are meant to be machine-specific and ignored by git

## Files

### [mason.lua](./mason.lua)
Local mason profile selection and extra LSP/tool overrides.  
**Note:** profiles stack on top of the defaults, not replace them.

```lua
return {
  enabled_profiles = {
    "web",
    "go",
  },
  extra_lsp = {
    -- "templ",
  },
  extra_tools = {
    -- "codespell",
  },
}
```
