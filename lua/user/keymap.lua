vim.keymap.set('n', 'C-x', [[:close<CR>]], { remap = true })

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

vim.keymap.set('n', 'K', vim.lsp.buf.hover, { remap = true })
vim.keymap.set('n', '<leader>qf', vim.diagnostic.setqflist, { remap = true })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { remap = true })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { remap = true })


-- Open and close the terminal blAZinGly FaST
vim.keymap.set('n', '<leader>to', [[:split|term<CR><C-W>J]])
-- If you ever have 99 split buffers open, in a single window, it may be time to go see a doctor
vim.keymap.set('n', '<leader>tc', [[<C-W>99j<C-W><C-Q>]])
-- Quicksave
vim.keymap.set('n', '<leader>ww', [[:w<CR>]])

-- vim.keymap.set('n', '<leader>nt', ':Telescope file_browser<CR>', {noremap = true})

vim.keymap.set('n', '<leader>tt', '[[:tabnew<CR]]>')
