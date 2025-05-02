local api = vim.api
local buf = nil
local options = { language = nil }

local M = {}

local function createBuf()
  buf = api.nvim_create_buf(true, true)

  api.nvim_buf_set_name(buf, "scratchpad")
  api.nvim_buf_set_option(buf, "filetype", options.language) -- Fixed typo here
end

local function open()
  if buf == nil then
    createBuf()
  end
  -- Open the buffer in a new window
  local win = api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = 80,
    height = 20,
    col = 10,
    row = 10,
    anchor = 'NW',
    border = 'rounded',
  })
  api.nvim_win_set_option(win, 'wrap', false) -- Optional: Set wrap option
end

local function close()
  if buf == nil then
    return
  else
    api.nvim_buf_set_lines(buf, 0, -1, false, {})
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

  api.nvim_create_user_command(
    "ScratchClose",
    function()
      close()
    end,
    { nargs = 0 }
  )
end

function M.setup(opts)
  options = opts
  createUserCommands()
end

return M
