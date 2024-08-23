local status, nvim_tree = pcall(require, 'nvim-tree')
if (not status) then return end

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opts = {
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true
  },
  filters = {
    custom = { "^.git" },
    exclude = { ".gitignore" }
  }
}

nvim_tree.setup(opts)

vim.keymap.set('n', '<leader>nt', [[:NvimTreeOpen<CR>]])
vim.keymap.set('n', '<leader>ntf', [[:NvimTreeFocus<CR>]])
vim.keymap.set('n', '<leader>ntt', [[:NvimTreeToggle<CR>]])
