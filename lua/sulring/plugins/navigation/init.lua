return {
	require("sulring.plugins.navigation.telescope"),
	{
		"Sulring/tagonaut.nvim",
		name = "tagonaut",
		dependencies = {
			"plenary",
			"devicons",
			"nerdicons",
      "nui"
		},
		config = function()
			require("tagonaut").setup({})
		end,
	},
	{
		"prichrd/netrw.nvim",
		---@diagnostic disable
		config = function()
			require("netrw").setup({
				use_devicons = true,
				mappings = {
					["X"] = function(payload)
						if payload.type == 1 then
							local path = payload.dir .. "/" .. payload.node
							local current_perm = vim.fn.getfperm(path)
							local is_executable = string.match(current_perm, "x$")

							if is_executable then
								vim.fn.system("chmod -x " .. vim.fn.shellescape(path))
							else
								vim.fn.system("chmod +x " .. vim.fn.shellescape(path))
							end
							vim.cmd("edit " .. vim.fn.fnameescape(payload.dir))
						end
					end,
				},
			})
		end,
	},
}
