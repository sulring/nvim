return {
	"numToStr/Comment.nvim",
	config = function()
		require("Comment").setup({
			padding = true,
			sticky = true,
			ignore = nil,
			toggler = {
				line = "--",
				block = "-b",
				opleader = {
					line = "--",
					block = "-b",
				},
				extra = {
					above = "-O",
					below = "-o",
					eol = "-A",
				},
			},
		})
	end,
}
