local util = require("scilla.util")

-- Plugin options
local options = { scilla_fmt = "scilla-fmt" }

local M = {}

-- Runs `scilla-fmt` on the current buffer.
function M:scilla_fmt()
  local filename = util.get_filename()
  local success, formatted, errors =
    util.run_cmd(string.format("%s %s", options.scilla_fmt, filename))
  if not success then
    error(string.format("Cannot format %s:\n%s", filename, errors))
    return
  end
  success = util.write_file(filename, formatted)
  if not success then
    error(string.format("Cannot write changes to %s", filename))
  end
  vim.cmd(":e!")
end

return M
