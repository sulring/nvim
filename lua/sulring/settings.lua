-- Volta nvim:
print("Configuration loaded successfully")
--
vim.g.node_host_prog = "/home/BolotinI/.volta/bin/neovim-node-host"

-- Numbers
--
vim.opt.number = true
vim.opt.relativenumber = true


local function set_language_settings(opts)
	vim.bo.expandtab = opts.indent_type == "Spaces"
	vim.bo.tabstop = opts.indent_width
	vim.bo.shiftwidth = opts.indent_width
	vim.bo.softtabstop = opts.indent_width
	vim.bo.autoindent = true
	vim.bo.smartindent = true

	vim.bo.textwidth = opts.column_width
	vim.opt_local.fileformat = opts.line_endings:lower()
end

local language_settings = {
	lua = {
		column_width = 120,
		line_endings = "Unix",
		indent_type = "Spaces",
		indent_width = 2,
		quote_style = "AutoPreferDouble",
		call_parentheses = "None",
	},
	python = {
		column_width = 88, -- Black formatter default
		line_endings = "Unix",
		indent_type = "Spaces",
		indent_width = 4,
		quote_style = "AutoPreferDouble",
		call_parentheses = "None",
	},
	javascript = {
		column_width = 80,
		line_endings = "Unix",
		indent_type = "Spaces",
		indent_width = 2,
		quote_style = "Single",
		call_parentheses = "None",
	},
	javascriptreact = {
		column_width = 80,
		line_endings = "Unix",
		indent_type = "Spaces",
		indent_width = 2,
		quote_style = "Double",
		call_parentheses = "None",
	},
	typescript = {
		column_width = 80,
		line_endings = "Unix",
		indent_type = "Spaces",
		indent_width = 2,
		quote_style = "Single",
		call_parentheses = "None",
	},
	typescriptreact = {
		column_width = 80,
		line_endings = "Unix",
		indent_type = "Spaces",
		indent_width = 2,
		quote_style = "Single",
		call_parentheses = "None",
	},
	sh = {
		column_width = 80,
		line_endings = "Unix",
		indent_type = "Spaces",
		indent_width = 4,
		quote_style = "Single",
		call_parentheses = "None",
	},
	-- Add more languages as needed
}

for lang, settings in pairs(language_settings) do
	vim.api.nvim_create_autocmd("FileType", {
		pattern = lang,
		callback = function()
			set_language_settings(settings)
		end,
	})
end

vim.g.tpipeline_statusline = "%f %m%r %y %p%% %l:%c"
