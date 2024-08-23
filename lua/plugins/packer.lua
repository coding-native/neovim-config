local function ensure_packer()
  local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    print('Installing packer...')
    local packer_url = 'https://github.com/wbthomason/packer.nvim'
    vim.fn.system({ 'git', 'clone', '--depth', '1', packer_url, install_path })
    print('Done.')

    vim.cmd('packadd packer.nvim')
    return true
  end

  return false
end

-- You can "comment out" the line below after packer is installed
local install_plugins = ensure_packer()


require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim' }

  -- LSP and Code Completion
  use { 'neovim/nvim-lspconfig' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-cmdline' }
  use { 'hrsh7th/nvim-cmp' }
  use { 'L3MON4D3/LuaSnip' }
  use { 'saadparwaiz1/cmp_luasnip' }

  -- Telescope
  use { 'nvim-lua/popup.nvim' }
  use { 'nvim-lua/plenary.nvim' }
  use { "nvim-telescope/telescope.nvim",
    requires = {
      { 'nvim-telescope/telescope-live-grep-args.nvim' },
      { 'nvim-telescope/telescope-file-browser.nvim' },
      { 'nvim-telescope/telescope-ui-select.nvim' },

    },
    config = function()
      local telescope = require('telescope')
      telescope.load_extension('live_grep_args')
      telescope.load_extension('file_browser')
    end
  }

  -- Session Management
  use {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    -- Plenary installed elsewhere
    -- requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter' }


  -- Git
  use { 'lewis6991/gitsigns.nvim' }

  -- Language Tools
  use { 'windwp/nvim-autopairs' }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-commentary' }
  use { 'ap/vim-css-color' }
  use { 'towolf/vim-helm', ft = 'helm' }
  use { 'joerdav/templ.vim' }
  use { 'stevearc/conform.nvim' }

  -- Symbol & Tree Explorer, Sleeick Tabs, Statuslin
  use { 'nvim-tree/nvim-web-devicons' }
  use { 'nvim-tree/nvim-tree.lua' }
  use { 'akinsho/bufferline.nvim' }
  use { 'nvim-lualine/lualine.nvim' }
  use { 'simrat39/symbols-outline.nvim' }

  -- Miscellaneous
  use { 'folke/tokyonight.nvim' }
  use { 'iamcco/markdown-preview.nvim',

    run   = "cd app && npm install",
    setup = function()
      vim.g.mkdp_auto_start = 1
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_filetypes = { 'markdown' }
      vim.g.mkdp_open_to_world = 1
      vim.g.mkdp_port = 6969
      vim.g.mkdp_theme = 'dark'
    end
  }
  use { 'esensar/nvim-dev-container' }
  use { "nomnivore/ollama.nvim",
    requires = {
      { "stevearc/dressing.nvim" }
    }
  }

  use { 'mg979/vim-visual-multi' }

  -- Custom
  -- use '~/.nvim/custom-plugins/nvim-docker'

  if install_plugins then
    require('packer').sync()
  end
end)

if install_plugins then
  print '=================================='
  print '    Plugins will be installed.'
  print '      After you press Enter'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

vim.api.nvim_create_user_command(
  'ReloadConfig',
  'source $MYVIMRC | PackerCompile',
  {}
)
