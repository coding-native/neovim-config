local event = { "BufRead", "BufNewFile" }
vim.api.nvim_create_autocmd(event, {
  pattern = { "*.bicep" },
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_set_option_value('filetype', 'bicep', { buf = buf })
  end
})

vim.api.nvim_create_autocmd(event, {
  pattern = { "*.*.tera" },
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_set_option_value('filetype', 'tera', { buf = buf })
  end
})
