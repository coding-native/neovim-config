require('nvim-treesitter.install').compilers = {"clang", "gcc"}

local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

ts.setup {
  highlight = {
    enable = true,
    disable = {"bash"},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    "bash",
    "c",
    "css",
    "c_sharp",
    "cmake",
    "cpp",
    "diff",
    "dockerfile",
    "go",
    "graphql",
    "html",
    "jsdoc",
    "json",
    "json5",
    "latex",
    "lua",
    "make",
    "markdown",
    "python",
    "regex",
    "rust",
    "scss",
    "sql",
    "terraform",
    "toml",
    "tsx",
    "yaml",
  },
  autotag = {
    enable = true
  },
  rainbow = {
    enabled = true,
    extended_mode = true,
    max_file_lines = nil
  }
}

local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
parser_config.tsx.filetype_to_parsername = {'javascript', 'typescript.tsx'}
