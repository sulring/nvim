return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "pmizio/typescript-tools.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "hrsh7th/cmp-nvim-lsp",
      },
    },
    {
      "williamboman/mason.nvim",
      cmd = "Mason",
      config = function()
        require("mason").setup()
      end,
    },
    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        ensure_installed = {
          "eslint",
          "html",
          "cssls",
          "tailwindcss",
          "emmet_ls",
          "lua_ls",
          "rust_analyzer",
          "pyright",
          "bashls",
          "jsonls",
          "yamlls",
          "marksman",
          "taplo",
        },
        automatic_installation = true,
      }
    },
    "b0o/SchemaStore.nvim",
  },
  config = function()
    -- Set up Mason first
    require("mason").setup()

    -- Debug LSP attachments
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
      end,
    })

    -- Set filetype associations
    vim.filetype.add({
      extension = {
        js = "javascript",
        jsx = "javascriptreact",
        ts = "typescript",
        tsx = "typescriptreact",
      },
      filename = {
        [".eslintrc"] = "json",
        [".prettierrc"] = "json",
        [".babelrc"] = "json",
      },
      pattern = {
        ["%.js$"] = "javascript",
        ["%.jsx$"] = "javascriptreact",
        ["%.ts$"] = "typescript",
        ["%.tsx$"] = "typescriptreact",
      },
    })

    -- Set up LSP servers
    local utils = require("sulring.plugins.lsp.utils")
    local servers = require("sulring.plugins.lsp.servers")
    servers.setup(require("lspconfig"), utils)

    -- Commands
    vim.api.nvim_create_user_command("OrganizeImports", function()
      vim.lsp.buf.execute_command({
        command = "_typescript.organizeImports",
        arguments = { vim.api.nvim_buf_get_name(0) },
      })
    end, {})
  end,
}
