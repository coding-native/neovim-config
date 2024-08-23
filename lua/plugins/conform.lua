local status, conform = pcall(require, "conform")
if (not status) then return end

local opts = {
  formatters_by_ft = {
    go = { "gofmt", "goimports", "golines" },
    html = { "prettierd" },
    javascript = { "prettierd" },
    python = { "ruff_format", "ruff_organize_imports" },
    rust = { "rustfmt" },
    typescript = { "prettierd" },
    templ = { "templ" }
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback"
  }
}

conform.setup(opts)

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end
})
