local event = "BufWritePre"

local goimports = function()
  local lsp_params = vim.lsp.util.make_range_params()
  lsp_params.context = {only = {"source.organizeImports"}}

  local res = vim.lsp.buf_request_sync(0, "textDocument/codeAction", lsp_params)
  for cid, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        local encoding = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
        vim.lsp.util.apply_workspace_edit(r.edit, encoding)
      end
    end
  end
  vim.lsp.buf.format({async=false})
end

vim.api.nvim_create_autocmd({event}, {
  pattern = "*.go",
  callback = goimports
})
