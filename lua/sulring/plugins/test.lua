return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"marilari88/neotest-vitest",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-vitest"),
			},
			-- Optional configuration
			discovery = {
				enabled = true,
			},
			diagnostic = {
				enabled = true,
			},
			status = {
				enabled = true,
				signs = true,
				virtual_text = true,
			},
		})

		-- Keymaps
		local neotest = require("neotest")
		vim.keymap.set("n", "<leader>tt", function()
			neotest.run.run(vim.fn.expand("%"))
		end, { desc = "Run File" })

		vim.keymap.set("n", "<leader>tn", function()
			neotest.run.run()
		end, { desc = "Run Nearest" })

		vim.keymap.set("n", "<leader>td", function()
			neotest.run.run({ strategy = "dap" })
		end, { desc = "Debug Nearest" })

		vim.keymap.set("n", "<leader>ts", function()
			neotest.summary.toggle()
		end, { desc = "Toggle Summary" })

		vim.keymap.set("n", "<leader>to", function()
			neotest.output.open({ enter = true })
		end, { desc = "Show Output" })

		vim.keymap.set("n", "<leader>tS", function()
			neotest.run.stop()
		end, { desc = "Stop" })
	end,
	keys = {
		{ "<leader>tt", desc = "Run File" },
		{ "<leader>tn", desc = "Run Nearest" },
		{ "<leader>td", desc = "Debug Nearest" },
		{ "<leader>ts", desc = "Toggle Summary" },
		{ "<leader>to", desc = "Show Output" },
		{ "<leader>tS", desc = "Stop" },
	},
}
