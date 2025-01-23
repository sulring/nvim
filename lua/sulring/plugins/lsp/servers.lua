local M = {}

function M.setup(lspconfig, utils)
  -- TypeScript Tools (replacement for ts_ls)
  require("typescript-tools").setup({
    on_attach = utils.on_attach,
    capabilities = utils.capabilities,
    settings = {
      separate_diagnostic_server = true,
      publish_diagnostic_on = "insert_leave",
      expose_as_code_action = "all",
      tsserver_format_options = {
        allowIncompleteCompletions = false,
        allowRenameOfImportPath = false,
      },
      tsserver_file_preferences = {
        includeInlayParameterNameHints = "all",
        includeCompletionsForModuleExports = true,
        quotePreference = "auto",
      },
      code_lens = "all",
      jsx_close_tag = {
        enable = true,
        filetypes = { "javascriptreact", "typescriptreact" },
      },
    },
  })

  -- Tailwind CSS
  lspconfig.tailwindcss.setup({
    on_attach = utils.on_attach,
    capabilities = utils.capabilities,
    settings = {
      tailwindCSS = {
        experimental = {
          classRegex = {
            "styled\\([^)]*\\).*`([^`]*)`",
            "tw`([^`]*)",
            "tw=\"([^\"]*)",
            "tw={\"([^\"}]*)",
            "tw\\.\\w+`([^`]*)",
            "tw\\(.*?\\)`([^`]*)",
          },
        },
        validate = true,
        hovers = true,
        suggestions = true,
        classAttributes = { "class", "className", "classList", "ngClass" },
      },
    },
  })

  -- HTML
  lspconfig.html.setup({
    on_attach = utils.on_attach,
    capabilities = utils.capabilities,
    filetypes = { "html", "javascriptreact", "typescriptreact" },
  })

  -- CSS
  lspconfig.cssls.setup({
    on_attach = utils.on_attach,
    capabilities = utils.capabilities,
    settings = {
      css = {
        validate = true,
        lint = {
          unknownAtRules = "ignore",
        },
      },
    },
  })

  lspconfig.eslint.setup({
    on_attach = function(client, bufnr)
      utils.on_attach(client, bufnr)
      -- Enable formatting
      client.server_capabilities.documentFormattingProvider = true
    end,
    capabilities = utils.capabilities,
    settings = {
      format = true,
      packageManager = "npm", -- or "yarn", "pnpm"
    },
  })

  lspconfig.ruff.setup({
    on_attach = utils.on_attach,
    capabilities = utils.capabilities,
    init_options = {
      settings = {
        -- Ruff settings here
      }
    }
  })

  -- Other servers with basic setup
  local servers = {
    "emmet_ls",
    "jsonls",
    "lua_ls",
    "pyright",
    "rust_analyzer",
    "bashls",
    "marksman",
    "yamlls",
    "taplo",
  }

  for _, server in ipairs(servers) do
    lspconfig[server].setup({
      on_attach = utils.on_attach,
      capabilities = utils.capabilities,
    })
  end
end

return M
