return {
	{
		"nvim-treesitter/nvim-treesitter",
		name = "treesitter",
		--build = ':TSUpdate',
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
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
					"python",
					"typescript",
					"rust",
					"markdown",
					"css",
				},
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
				ignore_install = {},
				auto_install = true,
			})
		end,
	},
}
