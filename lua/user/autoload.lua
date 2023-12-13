local event = {
  'BufEnter',
  'CursorHold',
  'CursorHoldI',
  'FocusGained',
}

local proc = function ()
  local modifiable = vim.api.nvim_get_option_value('modifiable', {buf=0})
  local command_mode = vim.api.nvim_get_mode().mode == 'c'

  if ( modifiable and not command_mode ) then
    vim.cmd [[ checktime ]]
  end
end

local error = function () end

vim.api.nvim_create_autocmd(event, {
  callback = function()
    xpcall(proc, error)
  end
})
