local status, devcontainer = pcall(require, 'devcontainer')
if (not status) then return end

local opts = {
  attach_mounts = {
    neovim_config = {
      enabled = true,
      options = { "readonly" },
    },
    neovim_data = {
      enabled = false,
      options = {}
    },
    neovim_state = {
      enabled = false,
      options = {}
    }
  }
}

devcontainer.setup(opts)

vim.keymap.set('n', '<leader>dcs', [[:DevcontainerStart<CR>]])
vim.keymap.set('n', '<leader>dca', [[:DevcontainerAttach<CR>]])
vim.keymap.set('n', '<leader>dcr', [[:DevcontainerStop<CR>]])
vim.keymap.set('n', '<leader>dcf', [[:DevcontainerFullScreenEnter<CR>]])
vim.keymap.set('n', '<leader>dcff', [[:DevcontainerFullScreenExit<CR>]])
