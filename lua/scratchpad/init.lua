local api = vim.api

local M = {}

local function open()
  print("Open scratchpad from dev")
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

function M.setup()
  createUserCommands()
end

return M
