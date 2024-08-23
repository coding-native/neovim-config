require('nvim-treesitter.install').compilers = { "clang", "gcc" }

local status, ts = pcall(require, 'nvim-treesitter.configs')
if (not status) then return end

local parser_config
status, parser_config = pcall(require, 'nvim-treesitter.parsers')

if (not status) then return end
parser_config = parser_config.get_parser_configs()

local opts = {
  modules = {},
  ignore_install = {},
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    disable = { "bash" },
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    "bicep",
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
    "templ",
    "terraform",
    "toml",
    "tsx",
    "twig",
    "vim",
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

ts.setup(opts)
parser_config.tsx.filetype_to_parsername = { 'javascript', 'typescript.tsx' }
vim.treesitter.language.register('twig', 'tera')
