local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		if opts.desc then
			opts.desc = "keymaps.lua: " .. opts.desc
		end
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

-- Help

local whichkey = require("which-key")
map("n", "<leader>?", function()
	whichkey.show({ global = false })
end, { desc = "HELP ME!" })

map("n", "<C-a>", "ggVG", { desc = "Select All" })

map("n", "<CR>", "o<Esc>k", { desc = "newline below" })
map("n", "<S-CR>", "i<CR><Esc>k", { desc = "Split to new line" })

map("n", "s", "b", { desc = "backWord" })
map("n", "S", "B", { desc = "backWord Big" })
map({"n", "v"}, "c", "<Nop>" )
local opts = { noremap = true, silent = true }

-- Buffer control
map("n", "bs", ":enew<CR>", { desc = "new buffer" })
map("n", "bn", ":bn<CR>", { desc = "next buffer" })
map("n", "bp", ":bp<CR>", { desc = "prev buffer" })
map("n", "|", ":vsplit<CR>", opts)
map("n", "_", ":split<CR>", opts)

-- File control
map("n", "<leader>fe", vim.cmd.Ex, { desc = "File Explorer" })

-- undo
map("n", "<leader>u", vim.cmd.UndotreeToggle)
map("n", "U", vim.cmd.redo)

vim.api.nvim_set_keymap("n", "<Esc>", ":nohlsearch<CR>", { noremap = true, silent = true })

-- zenmode
local zenmode = require("zen-mode")
map("", "<leader>`", zenmode.toggle)

vim.keymap.set('n', '<M-y>', ':!copy -all %:p<CR>', { silent = true })
vim.keymap.set('n', '<M-S-y>', ':!copy -all --add %:p<CR>', { silent = true })

require("sulring.clipboard.mapping")
