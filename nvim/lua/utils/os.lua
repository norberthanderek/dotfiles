local M = {}

function M.is_windows()
  local ok, uname = pcall(vim.loop.os_uname)
  if not ok or not uname or not uname.version then
    return false
  end
  return uname.version:match("Windows") ~= nil
end

return M
