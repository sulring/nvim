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

-- Copy/Paste
map("n", "<C-a>", "ggVG", { desc = "Select All" })
map("i", "<C-p>", '<Esc>"+pi', { desc = "Paste in Insert" })
map("n", "<C-p>", '"+p', { desc = "Paste" })
map({ "v", "n" }, "<C-y>", '"+y', { desc = "Copy" })
map("n", "Y", "y$", { desc = "Copy to the end of line" })
-- New line
map("n", "<CR>", "o<Esc>k", { desc = "newline below" })

map("n", "s", "b", { desc = "backWord" })
map("n", "S", "B", { desc = "backWord Big" })
map({"n", "v"}, "c", "<Nop>" )
local opts = { noremap = true, silent = true }

-- Buffer control
map("n", "<leader>n", ":enew<CR>", { desc = "new buffer" })
map("n", "<leader>]", ":bn<CR>", { desc = "next buffer" })
map("n", "<leader>[", ":bp<CR>", { desc = "prev buffer" })
map("n", "<leader>|", ":vsplit<CR>", opts)
map("n", "<leader>_", ":split<CR>", opts)

-- Remap switching between panes to Ctrl + Arrows
-- map("n", "<A-Left>", "<C-w>h", opts)
-- map("n", "<A-Down>", "<C-w>j", opts)
-- map("n", "<A-Up>", "<C-w>k", opts)
-- map("n", "<A-Right>", "<C-w>l", opts)

-- Remap switching between panes to Ctrl + h/j/k/l
-- map("n", "<A-h>", "<C-w>h", opts)
-- map("n", "<A-j>", "<C-w>j", opts)
-- map("n", "<A-k>", "<C-w>k", opts)
-- map("n", "<A-l>", "<C-w>l", opts)

-- File control
map("n", "<leader>fe", vim.cmd.Ex, { desc = "File Explorer" })
map("n", "<leader><tab>", "<cmd>Neotree toggle<CR>", { desc = "NeoTree" })
map({ "n", "v" }, "<leader>w", "<Esc>:w<CR>", { desc = "Save Buffer" })

-- undo
map("n", "<leader>u", vim.cmd.UndotreeToggle)
map("n", "u", vim.cmd.undo)
map("n", "U", vim.cmd.redo)

-- completion
map("i", "<C-Space>", "<C-N>", { noremap = true })
map("i", "<S-Space>", "<C-P>", { noremap = true })

-- function select
map("n", "<leader>{", "f{va}V", { desc = "Select Function" })

-- lsp rename
vim.api.nvim_set_keymap("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Esc>", ":nohlsearch<CR>", { noremap = true, silent = true })

-- zenmode
local zenmode = require("zen-mode")
map("", "<leader>`", zenmode.toggle)
