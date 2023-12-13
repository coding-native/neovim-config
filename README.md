# Ready To Use Neovim Configuration

## Before you `git clone`
I've been using Neovim for a bit over a year and have enjoyed various distros, such as AstroNvim, LazyVim, and others. However, I always felt bothered by the fact that I had absolutely no clue what was going on with the distros, or what gave them their magic.

This configuration is the culmination of of me trying out various different plugins, keymaps, and leader shortcuts (e.g. type `;ff`, in normal mode to bring up telescope), to find something that best fits my workflow.

There are a number of different plugins that one could use, in order to get their Neovim to do the same (or similar) things to mine, however, I have chosen the ones, used in this repository because I have found that they worked better for me than others.

Feel free to fork this configuration, in order to get yours started. I won't accept contributions to this repo, since it is my personal Neovim config.

Be sure you're using the latest stable version of Neovim, before using this config. Most of these plugins require Neovim 0.8+, or Neovim 0.9+.

I am using Neovim under WSL 2. If you are using Neovim on a bare metal Linux host, double check the configuration to ensure that you're publishing any background servers to localhost, not your NIC.

## Plugins used

### Plugin Manager
- wbthomason/packer.nvim

### LSP, Completion, Snippets
- (neovim/nvim-lspconfig)[https://github.com/neovim/nvim-lspconfig]
- (hrsh7th/cmp-nvim-lsp)[https://github.com/hrsh7th/cmp-nvim-lsp]
- (hrsh7th/cmp-buffer)[https://github.com/hrsh7th/cmp-buffer]
- (hrsh7th/cmp-path)[https://github.com/hrsh7th/cmp-path]
- (hrsh7th/cmp-cmdline)[https://github.com/hrsh7th/cmp-cmdline]
- (hrsh7th/nvim-cmp)[https://github.com/hrsh7th/nvim-cmp]
- (L3MON4D3/LuaSnip)[https://github.com/L3MON4D3/LuaSnip]
- (saadparwaiz1/cmp_luasnip)[https://github.com/saadparwaiz1/cmp_luasnip]

### Telescope
- (nvim-lua/popup.nvim)[https://github.com/nvim-lua/popup.nvim]
- (nvim-lua/plenary.nvim)[https://github.com/nvim-lua/plenary.nvim]
- (nvim-telescope/telescope.nvim)[https://github.com/nvim-telescope/telescope.nvim]
- (nvim-telescope/telescope-file-browser.nvim)[https://github.com/nvim-telescope/telescope-file-browser.nvim]

### Treesitter
- (nvim-treesitter/nvim-treesitter)[https://github.com/nvim-treesitter/nvim-treesitter]

### Git
- (lewis6991/gitsigns.nvim)[https://github.com/lewis6991/gitsigns.nvim]

### Language Tools
- (windwp/nvim-autopairs)[https://github.com/windwp/nvim-autopairs]
- (tpope/vim-surround)[https://github.com/tpope/vim-surround]
- (tpope/vim-commentary)[https://github.com/tpope/vim-commentary]
- (ap/vim-css-color)[https://github.com/ap/vim-css-color]
- (towolf/vim-helm)[https://github.com/towolf/vim-helm]

### Symbol & Tree Explorer, Sleeick Tabs, Statuslin
- (nvim-tree/nvim-web-devicons)[https://github.com/nvim-tree/nvim-web-devicons]
- (simrat39/symbols-outline.nvim)[https://github.com/simrat39/symbols-outline.nvim]
- (akinsho/bufferline.nvim)[https://github.com/akinsho/bufferline.nvim]
- (nvim-lualine/lualine.nvim)[https://github.com/nvim-lualine/lualine.nvim]
- (nvim-tree/nvim-tree.lua)[https://github.com/nvim-tree/nvim-tree.lua]

### Miscellaneous
- (folke/tokyonight.nvim)[https://github.com/folke/tokyonight.nvim]
- (iamcco/markdown-preview.nvim)[https://github.com/iamcco/markdown-preview.nvim]
- (esensar/nvim-dev-container)[https://github.com/esensar/nvim-dev-container]

## LSP
I'm using good ol' `nvim-lspconfig`/`nvim-cmp`/`LuaSnip` for LSP, code completion and snippets. Please see the installation instructions in (server_configurations)[https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md], to get your language servers installed.

### Bicep
I'm an Azure nerd, so there's a filetype for bicep files in here. Make sure to install bicep using `:TSInstall`. This filetype must be loaded into init.lua before lsp-config, if you are going to use the bicep language server

### Azure Pipelines Language Server
I'm also an Azure DevOps nerd. The Azure Pipelines Language Server is a hack'd up version of Yaml Language Server, but with support for Azure Pipelines Expressions.

In order for the language server to work, you will need to create a file called `azure-pipelines-language-server`, somewhere in your PATH (I use `/usr/local/bin`). That file will look something like the following:

```bash
#! /usr/bin/bash

export nodeversion=$(node --version)
export binpath=/home/<user>/.nvm/versions/node/$nodeversion/lib/node_modules/azure-pipelines-language-server/out

node $binpath/server.js $1
```

After you create this file, do not forget to `chmod 751`.

## Devcontainers
I use (nvim-dev-container)[https://github.com/esensar/nvim-dev-container], although I've needed to use some shennanigans, in order to get my config in there. My solution is to mount the config from `~/.config/nvim` to `/home/<user>/.config/nvim`, or `/root/.config/nvim` if you're mounting your devcontainer as root. I specify a bind mount in a docker compose file to acheive that solution.

To start a devcontainer, enter normal mode and type `;dcs`, then type `;dca` to start and attach the container. After you attach the container, you can enter "fullscreen mode". Fullscreen mode closes the outer NvimTree and bufferline, so that you only see the NvimTree and bufferline sessions for the devcontainer. To get out of this mode, enter normal mode and type `;dcff`.

> Note: You need to install neovim and your LSPs in your container. I recommend doing this during the image build.


## Some things I stuffed in here

### Autosave/Autoload
I wanted a VSCode-like experience, without eating so much of my machine's resources. It's not exactly VSCode-like, however, if you need to remember to `<C-c>:w<CR>`, every time you switch a file.

The code in `lua/user/autosave.lua` creates an autocommand, which calls `:w`, every time the buffer leaves focus. If you change files, split the buffer, enter NvimTree, or open a terminal, it will automatically save the file for you. Exiting Neovim with `<C-W><C-Q>` will also emit the `BufLeave` event, thus saving your file.

The code in `lua/user/autoload.lua` creates an autocommand, which calls `:checktime` every time the buffer is focused. Calling `:checktime` will refresh the current buffer, with the latest version of the file, if the file was updated, outside of the buffer. This will overwrite any unsaved changes in the buffer, however with autosave, this shouldn't be an issue, since the file will always be saved after the buffer loses focus.

> IMPORTANT: If you force exit Neovim, or close the terminal session running Neovim, autosave will not trigger. Additionally, if you are using a tiling window manager, focusing a different tile will not trigger autosave. That is because Neovim, in its tile, thinks your cursor is still inside of the editable buffer.


### Powershell
I use Neovim on Windows, from time-to-time. If you also hate yourself, add the following line to `init.lua`:
```lua
require "user.shell"
```
This line will force Neovim's default terminal emulator to use Powershell instead of CMD.

### Quicksave
There's an old programming proverb: "save often." I created some code that provides a bit of stress relief in `lua/user/keymap.lua`. In normal mode, type `;ww` to quicksave. Why not just use `:w`? Because of the number of times I saw `:W is not a command` made me think of something better.

### Quickly Open/Close Terminal
I like using the Neovim terminal emulator. Especially after getting autosave working, I like having the ability to jump between a command line and my file, without needing to think about saving. To speedily open up a new terminal session, enter normal mode and type `;to`. This will split the buffer horizontally, pin the new buffer to the very bottom of the screen (below both the file buffer and the NvimTree buffer) and open a new terminal session in the Buffer. To quickly close the bottom pinned terminal, enter normal mode and type `;tc`. Please try not to do more than 99 horizontal splits, or this will stop working as described (see comment in `lua/user/keymap.lua`)
