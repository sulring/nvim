return {
  {
    "nvim-treesitter/nvim-treesitter",
    name = "treesitter",
    build = ':TSUpdate',
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        modules = {},
        ensure_installed = {
          "c",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "elixir",
          "heex",
          "javascript",
          "html",
          "tsx",
          "python",
          "regex",
          "typescript",
          "rust",
          "markdown",
          "css",
        },
        sync_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "javascriptreact" },
        },
        indent = { enable = true },
        ignore_install = {},
        auto_install = true,
      })
    end,
  },
  "styled-components/typescript-styled-plugin"
}
