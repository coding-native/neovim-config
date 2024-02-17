require "user.opts"
require "user.keymap"
require "user.autosave"
require "user.autoload"
require "user.filetypes"
require "user.autoformat"
require "user.commands"

require "plugins.packer"
require "plugins.telescope"
require "plugins.lsp-config"
require "plugins.tree-sitter"
require "plugins.git"
require "plugins.autopairs"

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require "plugins.bufferline"
require "plugins.lualine"
require "plugins.symbols"
require "plugins.tree"
require "plugins.devcontainers"
require "plugins.theme"

vim.cmd [[ colorscheme tokyonight-night ]]
vim.lsp.set_log_level("debug")
