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
		"nvim-neo-tree/neo-tree.nvim",
		name = "neotree",
		branch = "v3.x",
		dependencies = {
			"plenary",
			"devicons",
			"nui",
			"3rdimage",
		},
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
		dir = "~/dev/metamorph.nvim",
		name = "metamorph",
		dev = true,
		dependencies = {
			"plenary",
			"telescope",
		},
		config = function()
			require("metamorph").setup()
		end,
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
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		enabled = false,
		disabled = true,
		config = function()
			require("toggleterm").setup({
				-- Your ToggleTerm options here
				on_open = function(term)
					-- Set up terminal keymaps when a terminal is opened
					local opts = { buffer = term.bufnr, noremap = true, silent = true }
					vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
					vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
					vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
					vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
					vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
					vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)
					vim.keymap.set("n", "<F11>", "<C-w>k", opts)
					vim.keymap.set("t", "<F11>", [[<C-\><C-n><C-w>k]], opts)
				end,
			})

			vim.keymap.set("n", "<F11>", "<C-w>j", { noremap = true, silent = true })
			-- Set up F12 mappings with count support
			vim.keymap.set(
				"n",
				"<F12>",
				'<cmd>lua require("toggleterm").toggle(vim.v.count1)<CR>',
				{ noremap = true, silent = true }
			)
			vim.keymap.set(
				"i",
				"<F12>",
				'<Esc><cmd>lua require("toggleterm").toggle(vim.v.count1)<CR>',
				{ noremap = true, silent = true }
			)
			vim.keymap.set(
				"t",
				"<F12>",
				'<cmd>lua require("toggleterm").toggle(vim.v.count1)<CR>',
				{ noremap = true, silent = true }
			)
		end,
	},
	{
		"stevearc/conform.nvim",
		name = "conform",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				rust = { "rustfmt", lsp_format = "fallback" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
			},
			format_on_save = function(bufnr)
				local ignore_filetypes = { "sql", "java" }
				if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
					return
				end
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				local bufname = vim.api.nvim_buf_get_name(bufnr)
				if bufname:match("/node_modules/") then
					return
				end
				return { timeout_ms = 500, lsp_format = "fallback" }
			end,
		},
		keys = {
			{
				"<leader>i",
				function()
					require("conform").format({ async = true }, function(err)
						if not err then
							local mode = vim.api.nvim_get_mode().mode
							if vim.startswith(string.lower(mode), "v") then
								vim.api.nvim_feedkeys(
									vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
									"n",
									true
								)
							end
						end
					end)
				end,
				desc = "Format!",
			},
		},
	},
	{
		dir = "~/dev/vaura.nvim",
		name = "vaura",
		dev = true,
		config = function()
			require("vaura").setup()
		end,
	},
}
