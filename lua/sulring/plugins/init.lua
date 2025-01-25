return {

	require("sulring.plugins.lsp"),
	require("sulring.plugins.formatting"),
	require("sulring.plugins.navigation"),
	require("sulring.plugins.colorschemes"),
	require("sulring.plugins.comment"),
	require("sulring.plugins.treesitter"),
	require("sulring.plugins.utils"),
	require("sulring.plugins.zenmode"),
	require("sulring.plugins.diagnostics"),
	{
		"folke/drop.nvim",
		name = "drop",
		opts = {
			screensaver = 1000 * 10 *  15,
		},
	},
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
