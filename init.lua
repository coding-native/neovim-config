require "user.opts"
require "user.keymap"
require "user.autosave"
require "user.autoload"
require "user.filetypes"
require "user.commands"
require "user.zsh"

require "plugins.packer"
require "plugins.telescope"
require "plugins.harpoon"
require "plugins.tree-sitter"
require "plugins.git"
require "plugins.autopairs"
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
vim.lsp.set_log_level("debug")


vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#ec5f67' })
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#c678dd' })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#008080' })
