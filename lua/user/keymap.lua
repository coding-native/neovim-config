vim.keymap.set('n', 'C-x', [[:close<CR>]], { remap = true })


-- Open and close the terminal blAZinGly FaST
vim.keymap.set('n', '<leader>to', [[:split|term<CR><C-W>J]])
-- If you ever have 99 split buffers open, in a single window, it may be time to go see a doctor
vim.keymap.set('n', '<leader>tc', [[<C-W>99j<C-W><C-Q>]])
-- Quicksave
vim.keymap.set('n', '<leader>ww', [[:w<CR>]])

-- vim.keymap.set('n', '<leader>nt', ':Telescope file_browser<CR>', {noremap = true})

vim.keymap.set('n', '<leader>tt', '[[:tabnew<CR>]]')

-- Bufferline
vim.keymap.set('n', 'gt', [[:BufferLineCycleNext<CR>]])
vim.keymap.set('n', 'gT', [[:BufferLineCyclePrev<CR>]])

-- Devcontainers
vim.keymap.set('n', '<leader>dcs', [[:DevcontainerStart<CR>]])
vim.keymap.set('n', '<leader>dca', [[:DevcontainerAttach<CR>]])
vim.keymap.set('n', '<leader>dcr', [[:DevcontainerStop<CR>]])
vim.keymap.set('n', '<leader>dcf', [[:DevcontainerFullScreenEnter<CR>]])
vim.keymap.set('n', '<leader>dcff', [[:DevcontainerFullScreenExit<CR>]])

-- LSP
-- Code Completion (nvim-cmp)
--
-- Example maps, set your own with vim.api.nvim_buf_set_keymap(buf, "n", <lhs>, <rhs>, { desc = <desc> })
-- or a plugin like which-key.nvim
-- <lhs>        <rhs>                        <desc>
-- "K"          vim.lsp.buf.hover            "Hover Info"
-- "<leader>qf" vim.diagnostic.setqflist     "Quickfix Diagnostics"
-- "[d"         vim.diagnostic.goto_prev     "Previous Diagnostic"
-- "]d"         vim.diagnostic.goto_next     "Next Diagnostic"
-- "<leader>e"  vim.diagnostic.open_float    "Explain Diagnostic"
-- "<leader>ca" vim.lsp.buf.code_action      "Code Action"
-- "<leader>cr" vim.lsp.buf.rename           "Rename Symbol"
-- "<leader>fs" vim.lsp.buf.document_symbol  "Document Symbols"
-- "<leader>fS" vim.lsp.buf.workspace_symbol "Workspace Symbols"
-- "<leader>gq" vim.lsp.buf.formatting_sync  "Format File"
local bufopts = { noremap = true, silent = true, buffer = bufnr }

vim.keymap.set('n', '<leader>go', [[:LspRestart<CR>]])
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, bufopts)
vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, bufopts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, bufopts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
vim.keymap.set('n', '<leader>qf', vim.diagnostic.setqflist, bufopts)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, bufopts)


-- Symbols Outline
vim.keymap.set('n', '<leader>so', [[:SymbolsOutline<CR>]])
vim.keymap.set('n', '<leader>soo', [[:SymbolsOutlineOpen<CR>]])
vim.keymap.set('n', '<leader>sc', [[:SymbolsOutlineClose<CR>]])


-- Nvim Tree
vim.keymap.set('n', '<leader>nt', [[:NvimTreeOpen<CR>]])
vim.keymap.set('n', '<leader>ntf', [[:NvimTreeFocus<CR>]])
vim.keymap.set('n', '<leader>ntt', [[:NvimTreeToggle<CR>]])
