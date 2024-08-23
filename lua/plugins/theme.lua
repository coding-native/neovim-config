local status, tokyonight = pcall(require, 'tokyonight')
if (not status) then return end

local opts = {
  transparent = true,
  hide_inactive_statusline = true,
  dim_inactive = true,
}

tokyonight.setup(opts)
