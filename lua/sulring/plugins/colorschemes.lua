return {
	{
		dir = "~/dev/suthema.nvim",
		name = "suthema",
		dev = true,
		config = function()
			require("suthema").setup({
        use_telescope = false
			})
		end,
	},

	{
		"olimorris/onedarkpro.nvim",
		lazy = true,
		priority = 1000,
		config = function()
			require("onedarkpro").setup({
				styles = {
					comments = "italic",
					functions = "bold",
					keywords = "italic",
					strings = "none",
					variables = "none",
				},
			})
		end,
	},

	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = true,
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				variant = "main",
				dark_variant = "main",
				bold_vert_split = false,
				dim_nc_background = false,
				disable_background = false,
				disable_float_background = false,
				disable_italics = false,
			})
		end,
	},

	{
		"wnkz/monoglow.nvim",
		lazy = true,
		priority = 1000,
	},

	{
		"kdheepak/monochrome.nvim",
		lazy = true,
		priority = 1000,
	},

	{
		"folke/tokyonight.nvim",
		lazy = true,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				style = "night",
				light_style = "day",
				transparent = false,
				terminal_colors = true,
				styles = {
					comments = { italic = true },
					keywords = { italic = true },
					functions = {},
					variables = {},
				},
			})
		end,
	},

	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				background = {
					light = "latte",
					dark = "mocha",
				},
				transparent_background = false,
				show_end_of_buffer = false,
				term_colors = false,
				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15,
				},
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
				},
			})
		end,
	},

	{
		"EdenEast/nightfox.nvim",
		lazy = true,
		priority = 1000,
		config = function()
			require("nightfox").setup({
				options = {
					compile_path = vim.fn.stdpath("cache") .. "/nightfox",
					compile_file_suffix = "_compiled",
					transparent = false,
					terminal_colors = true,
					dim_inactive = false,
					styles = {
						comments = "italic",
						conditionals = "NONE",
						constants = "NONE",
						functions = "NONE",
						keywords = "NONE",
						numbers = "NONE",
						operators = "NONE",
						strings = "NONE",
						types = "NONE",
						variables = "NONE",
					},
				},
			})
		end,
	},

	{
		"sainnhe/gruvbox-material",
		lazy = true,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_background = "medium"
			vim.g.gruvbox_material_foreground = "material"
			vim.g.gruvbox_material_better_performance = 1
			vim.g.gruvbox_material_enable_italic = 1
			vim.g.gruvbox_material_disable_italic_comment = 0
			vim.g.gruvbox_material_transparent_background = 0
		end,
	},
}
