local event = { 'BufLeave' }

local proc = function ()
  local modifiable = vim.api.nvim_get_option_value('modifiable', {buf=0})

  if ( modifiable ) then
    vim.cmd [[ write ]]
  end
end

local error = function () end

vim.api.nvim_create_autocmd(event, {
  callback = function()
    xpcall(proc, error)
  end
})
