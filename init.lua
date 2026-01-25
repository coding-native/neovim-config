--- Check if a program is executable
---@param executable string
---@return boolean is_executable
local function is_executable(executable)
  return vim.fn.executable(executable) == 1
end

--- Check if dev is using Microsoft Sad Time OS
---@return boolean is_windows
local function is_windows()
  return vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 or vim.fn.has("win16") == 1
end

require "plugins.packer"
require "user.opts"
require "user.keymap"
require "user.autosave"
require "user.autoload"
require "user.autocmds"
require "user.filetypes"
require "user.commands"

-- OS Agnostic Shell Setup
if is_windows() then
  require "user.powershell"
else
  if is_executable("zsh") then
    require "user.zsh"
  else
    require "user.bash"
  end
end

require "plugins.telescope"
require "plugins.harpoon"
require "plugins.tree-sitter"
require "plugins.git"
require "plugins.autopairs"
require "plugins.dap"
require "plugins.lsp-config"
require "plugins.conform"

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require "plugins.tree"
require "plugins.bufferline"
require "plugins.lualine"
require "plugins.symbols"
require "plugins.devcontainers"
require "plugins.ollama"
require "plugins.theme"

vim.cmd [[ colorscheme tokyonight-night ]]
vim.lsp.set_log_level("info")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#ec5f67' })
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#c678dd' })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#008080' })

