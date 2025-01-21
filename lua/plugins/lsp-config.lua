local status, lspconfig = pcall(require, 'lspconfig')
if (not status) then return end

local luasnip
status, luasnip = pcall(require, 'luasnip')
if (not status) then return end

local util = lspconfig.util

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functionssetGroups

vim.keymap.set('n', '<leader>go', [[:LspRestart<CR>]])

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })
  vim.api.nvim_create_autocmd('CursorHold', {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
      }
      vim.diagnostic.open_float(nil, opts)
    end
  })

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
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

  -- Code Completion (nvim-cmp)
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
  -- vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
  vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
  vim.api.nvim_set_option_value("tagfunc", "v:lua.vim.lsp.tagfunc", { buf = bufnr })
  if vim.bo[bufnr].buftype ~= "" or vim.api.nvim_get_option_value('filetype', { buf = bufnr }) == "helm" then
    vim.diagnostic.enable(false)
    vim.defer_fn(function()
      vim.diagnostic.reset(nil, bufnr)
    end, 1000)
  end
end

local cmp = require 'cmp'

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  mapping = { -- Preset: ^n, ^p, ^y, ^e, you know the drill..
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4)),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4)),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true })
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "path" },
  }, {
    { name = "buffer", keyword_length = 3 },
  }),
  experimental = {
    ghost_text = true
  }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}


lspconfig['azure_pipelines_ls'].setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    if vim.api.nvim_get_option_value('filetype', { buf = bufnr }) == "helm" then
      vim.lsp.stop_client(client.dynamic_capabilities.client_id, true)
      vim.lsp.buf_detach_client(bufnr, client.dynamic_capabilities.client_id)
    else
      on_attach(client, bufnr)
    end
  end,
  flags = lsp_flags,
  cmd = { "azure-pipelines-language-server", "--stdio" },
  root_dir = util.root_pattern('.git', '.env', 'docker-compose.yml', '.cicd'),
  settings = {
    yaml = {
      schemas = {
        ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
          "/.cicd/azure-pipelines/**/*.yml",
          "/.cicd/azure-pipelines/azure-pipelines.yml",
          "/azure-pipelines.yml",
        },
        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
          "/docker-compose.yml",
          "/docker-compose.*.yml",
          "/**/docker-compose.yml"
        },
      }
    }
  }
}

lspconfig['bashls'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags
}

lspconfig['clangd'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags
}

lspconfig['cmake'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags
}

lspconfig['csharp_ls'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags
}

lspconfig['cssls'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags
}

lspconfig['dockerls'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags
}

lspconfig['glsl_analyzer'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags
}

lspconfig['gopls'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  }
}

lspconfig['helm_ls'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
  settings = {
    ['helm-ls'] = {
      logLevel = "info",
      valuesFiles = {
        mainValuesFile = "values.yaml",
        lintOverlayValuesFile = "values.lint.yaml",
        additionalValuesFilesGlobPattern = "values*.yaml"
      },
      yamlls = {
        enabled = true,
        diagnosticsLimit = 50,
        showDiagnosticsDirectly = false,
        path = "yaml-language-server",
        config = {
          schemas = {
            kubernetes = ".k8s/chart/templates/**",
          },
          completion = true,
          hover = true,
        }
      }
    }
  }
}

lspconfig['jsonls'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
}

lspconfig['lsp_ai'].setup {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  on_attach = on_attach,
  lsp_flags = lsp_flags,
  root_dir = vim.fn.getcwd(),
  filetypes = {
    "c",
    "cpp",
    "css",
    "dockerfile",
    "go",
    "html",
    "lua",
    "java",
    "javascript",
    "json",
    "python",
    "rust",
    "toml",
    "typescript",
    "typescriptreact",
    "yaml",
  },
  init_options = {
    memory = {
      -- It is important to use this method as `{}` will be interpreted as an array when it should be an object
      file_store = vim.empty_dict()
    },
    models = {
      model1 = {
        type = "open_ai",
        chat_endpoint = "http://localhost:11434/v1/chat/completions",
        model = "qwen2.5-coder",
        auth_token = "ollama"
      }
    },
    actions = {
      {
        trigger = "!C",
        action_display_name = "Chat",
        model = "model1",
        parameters = {
          max_context = 4096,
          max_tokens = 4096,
          system = [[
You are an AI coding assistant. Your task is to complete code snippets. The user's cursor position is marked by \"<CURSOR>\". Follow these steps:
1. Analyze the code context and the cursor position.
2. Provide your chain of thought reasoning, wrapped in <reasoning> tags. Include thoughts about the cursor position, what needs to be completed, and any necessary formatting.
3. Determine the appropriate code to complete the current thought, including finishing partial words or lines.
4. Replace \"<CURSOR>\" with the necessary code, ensuring proper formatting and line breaks.
5. Wrap your code solution in <answer> tags.
Your response should always include both the reasoning and the answer. Pay special attention to completing partial words or lines before adding new lines of code.
]],
          messages = {
            {
              role = "user",
              content = "{CODE}"
            }
          },
          post_process = {
            extractor = "(?s)<answer>(.*?)</answer>"
          },
        },
      },
    },
    completion = {
      model = "model1",
      parameters = {
        max_context = 2000,
        options = {
          num_predict = 32
        },
        system = "Instructions:\n- You are an AI programming assistant.\n- Given a piece of code with the cursor location marked by \"<CURSOR>\", replace \"<CURSOR>\" with the correct code or comment.\n- First, think step-by-step.\n- Describe your plan for what to build in pseudocode, written out in great detail.\n- Then output the code replacing the \"<CURSOR>\"\n- Ensure that your completion fits within the language context of the provided code snippet (e.g., Python, JavaScript, Rust).\n\nRules:\n- Only respond with code or comments.\n- Only replace \"<CURSOR>\"; do not include any previously written code.\n- Never include \"<CURSOR>\" in your response\n- If the cursor is within a comment, complete the comment meaningfully.\n- Handle ambiguous cases by providing the most contextually appropriate completion.\n- Be consistent with your responses.",
        messages = {
          {
            role = "user",
            content = "def greet(name):\n    print(f\"Hello, {<CURSOR>}\")"
          },
          {
            role = "assistant",
            content = "name"
          },
          {
            role = "user",
            content = "function sum(a, b) {\n    return a + <CURSOR>;\n}"
          },
          {
            role = "assistant",
            content = "b"
          },
          {
            role = "user",
            content = "fn multiply(a: i32, b: i32) -> i32 {\n    a * <CURSOR>\n}"
          },
          {
            role = "assistant",
            content = "b"
          },
          {
            role = "user",
            content = "# <CURSOR>\ndef add(a, b):\n    return a + b"
          },
          {
            role = "assistant",
            content = "Adds two numbers"
          },
          {
            role = "user",
            content = "# This function checks if a number is even\n<CURSOR>"
          },
          {
            role = "assistant",
            content = "def is_even(n):\n    return n % 2 == 0"
          },
          {
            role = "user",
            content = "{CODE}"
          }
        }
      },
    },
  },
}

lspconfig['lua_ls'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' }
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enabled = false
      }
    }
  }
}

lspconfig['marksman'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
}

lspconfig['pyright'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
}

lspconfig['rust_analyzer'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
  -- Server-specific settings...
  settings = {
    ["rust-analyzer"] = {}
  }
}

lspconfig['tailwindcss'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
  root_dir = util.root_pattern(
    'tailwind.config.js',
    'tailwind.config.cjs',
    'tailwind.config.mjs',
    'tailwind.config.ts',
    'postcss.config.js',
    'postcss.config.cjs',
    'postcss.config.mjs',
    'postcss.config.ts',
    'package.json',
    'node_modules',
    '.git'),
  settings = {
    filetypes = {
      "aspnetcorerazor",
      "astro",
      "astro-markdown",
      "blade",
      "clojure",
      "django-html",
      "htmldjango",
      "edge",
      "eelixir",
      "elixir",
      "ejs",
      "erb",
      "eruby",
      "gohtml",
      "gohtmltmpl",
      "haml",
      "handlebars",
      "hbs",
      "html",
      "html-eex",
      "heex",
      "jade",
      "leaf",
      "liquid",
      "markdown",
      "mdx",
      "mustache",
      "njk",
      "nunjucks",
      "php",
      "razor",
      "rust",
      "slim",
      "twig",
      "css",
      "less",
      "postcss",
      "sass",
      "scss",
      "stylus",
      "sugarss",
      "javascript",
      "javascriptreact",
      "reason",
      "rescript",
      "typescript",
      "typescriptreact",
      "vue",
      "svelte",
      "templ",
    },
    tailwindCSS = {
      includeLanguages = {
        rust = "html",
        templ = "html"
      }
    }
  }
}

lspconfig['templ'].setup {}

lspconfig['ts_ls'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
  root_dir = util.root_pattern('package.json',
    'tsconfig.json', 'jsconfig.json', '.yarn')
}


lspconfig['vimls'].setup {}


local ls = require('luasnip')
vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })
