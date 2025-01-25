vim.api.nvim_create_user_command("Config", function(opts)
	local file = opts.args ~= "" and opts.args or "$MYVIMRC"
	vim.cmd("edit " .. (file:match("^%w+$") and "~/.config/nvim/" .. file or file))
end, { nargs = "?" })
