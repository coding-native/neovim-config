local status, telescope = pcall(require, "telescope")
if (not status) then return end

local actions
status, actions = pcall(require, 'telescope.actions')
if (not status) then return end

local lga_actions
status, lga_actions = pcall(require, 'telescope-live-grep-args.actions')
if (not status) then return end

local builtin
status, builtin = pcall(require, 'telescope.builtin')

local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, slient = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opts = {
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      }
    },
  },
  extensions = {
    live_grep_args = {
      auto_quoting = true,
      mappings = { -- extend mappings
        i = {
          ["<C-k>"] = lga_actions.quote_prompt(),
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
        },
      },
    }
  },
  file_browser = {
    theme = "tokyonight",
    -- disables netrw and use telescope-file-browser in its place
    hijack_netrw = true,
    mappings = {
      ["i"] = {
        -- your custom insert mode mappings
      },
      ["n"] = {
        -- your custom normal mode mappings
      },
    },
  },
}

telescope.setup(opts)

vim.keymap.set('n', '<leader>bb', builtin.buffers)
vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>fg', builtin.live_grep)
vim.keymap.set('n', '<leader>fb', ':Telescope file_browser<CR>', { noremap = true })
vim.keymap.set('n', '<leader>fbb', ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { noremap = true })
vim.keymap.set('n', '<leader>fh', builtin.help_tags)

