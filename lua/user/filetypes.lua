local event = {"BufRead","BufNewFile"}
vim.api.nvim_create_autocmd(event, {
  pattern = { "*.bicep" },
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_option(buf, 'filetype', 'bicep')
  end
})

vim.api.nvim_create_autocmd(event, {
  pattern = { "*.*.tera" },
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_option(buf, 'filetype', 'tera')
  end
})
