return {
  {
    "folke/which-key.nvim",
    name = "whichkey",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    "nvim-lua/plenary.nvim",
    priority = 1000,
    name = "plenary",
  },
  {
    "nvim-tree/nvim-web-devicons",
    name = "devicons",
    priority = 10,
  },
  {
    "glepnir/nerdicons.nvim",
    cmd = "NerdIcons",
    name = "nerdicons",
    config = function()
      require("nerdicons").setup({})
    end,
  },
  {
    "MunifTanjim/nui.nvim",
    name = "nui",
    priority = 10,
  },
  {
    "3rd/image.nvim",
    name = "3rdimage",
    priority = 10,
  },
  {
    "mbbill/undotree",
    name = "undotree",
  },
  "tpope/vim-fugitive",
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    name = "telescope",
    dependencies = {
      "plenary",
    },
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "plenary",
      "treesitter",
    },
    config = function()
      require("refactoring").setup()
    end,
  },
  require("sulring.plugins.lsp"),
  require("sulring.plugins.formatting"),
  {
    "folke/trouble.nvim",
    opts = {},
    name = "trouble",
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    dir = "~/dev/tagonaut.nvim",
    name = "tagonaut",
    dev = true,
    dependencies = {
      "plenary",
      "telescope",
      "devicons",
      "nerdicons",
    },
    config = function()
      require("tagonaut").setup({
        use_telescope = true,
      })
    end,
  },
  {
    "echasnovski/mini.surround",
    config = function()
      require("mini.surround").setup({
        mappings = {
          add = "sa",
          delete = "sd",
          find = "sf",
          find_left = "sF",
          highlight = "sh",
          replace = "sr",
          update_n_lines = "sn",

          suffix_last = "l",
          suffix_next = "n",
        },
      })
    end,
  },
}
