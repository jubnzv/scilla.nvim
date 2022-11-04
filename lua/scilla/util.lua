-- @return Content of a file.
local function read_file(filepath)
  local f = io.open(filepath)
  local result = f:read("*all")
  f:close()
  return result
end

local M = {}

-- @return Absolute path to the file in the current buffer
function M.get_filename()
  return vim.fn.expand("%:p")
end

-- Writes `content` to file `filepath`.
-- @return True iff write was successful
function M.write_file(filepath, content)
  local f = io.open(filepath, "w")
  local result = f:write(content)
  f:close()
  return result
end

-- Runs system command `cmd`.
-- @return A tuple (success, stdout, stderr)
function M.run_cmd(cmd)
  local exit_success = 0 -- SUCCESS return code
  local tmpfile = os.tmpname()
  local out_name = tmpfile
  local err_name = tmpfile
  local exit = os.execute(cmd .. " > " .. out_name .. " 2> " .. err_name)
  return exit == exit_success, read_file(out_name), read_file(err_name), stderr
end

return M
