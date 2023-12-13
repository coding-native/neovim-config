local function enter_fullscreen ()
  vim.opt.showtabline = 0
  vim.opt.number = false
  vim.opt.relativenumber = false
end

local function exit_fullscreen ()
  vim.opt.showtabline = -1
  vim.opt.number = true
  vim.opt.relativenumber = true
end

vim.api.nvim_create_user_command('DevcontainerFullScreenEnter', enter_fullscreen, { nargs = 0 })
vim.api.nvim_create_user_command('DevcontainerFullScreenExit', exit_fullscreen, { nargs = 0 })
