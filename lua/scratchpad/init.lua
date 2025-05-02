local api = vim.api
local buf = nil
local options = { language = nil }

local M = {}

local function createBuf()
  buf = api.nvim_create_buf(true, true)

  api.nvim_buf_set_name(buf, "scratchpad")
  api.nvim_buf_set_option(buf, "fliletype", options.language)
end

local function open()
  if buf == nil then
    createBuf()
  else
    api.nvim_open_win(buf, true, {})
  end
end

local function createUserCommands()
  api.nvim_create_user_command(
    "ScratchOpen",
    function()
      open()
    end,
    { nargs = 0 }
  )
end

function M.setup(opts)
  options = opts
  createUserCommands()
end

return M
