local M = {}

function M.prequire(modname, fn)
  local ok, mod = pcall(require, modname)

  if not ok then
    print("ERROR: failed to require " .. modname)
    return
  end

  if fn then fn(mod) end
  return mod
end

return M
