return {
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
}
