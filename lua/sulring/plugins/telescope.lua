return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	name = "telescope",
	dependencies = {
		"plenary",
	},
	config = function()
		local show_tests = false -- Default: hide test files
		local last_picker = nil -- Store the last used picker function

		local telescope = require("telescope")
		local builtin = require("telescope.builtin")

		local function get_file_ignore_patterns()
			if show_tests then
				return {
					"node_modules/",
					"%.git/",
				}
			else
				return {
					"node_modules/",
					"%.git/",
					"/test/", -- matches files in test directories
					"%.test%.", -- matches .test. files
					"%.spec%.", -- matches .spec. files
					"/tests/", -- matches files in tests directories
					"__tests__", -- matches files in __tests__ directories
				}
			end
		end

		local function get_oldfiles_results()
			local results = {}
			for _, file in ipairs(vim.v.oldfiles) do
				if vim.startswith(file, vim.fn.getcwd()) then
					table.insert(results, vim.fn.fnamemodify(file, ":."))
				end
				if #results >= 10 then
					break
				end
			end
			return results
		end

		local function create_find_files_picker()
			return function()
				local pickers = require("telescope.pickers")
				local finders = require("telescope.finders")
				local conf = require("telescope.config").values
				local make_entry = require("telescope.make_entry")

				pickers
					.new({}, {
						prompt_title = "Find Files",
						finder = finders.new_oneshot_job(vim.tbl_flatten({ "fd", "--type", "f" }), {
							entry_maker = make_entry.gen_from_file(),
						}),
						previewer = conf.file_previewer({}),
						sorter = conf.file_sorter({}),
						attach_mappings = function(prompt_bufnr, map)
							map("i", "<C-t>", function()
								local actions = require("telescope.actions")
								actions.close(prompt_bufnr)
								show_tests = not show_tests
								vim.notify(show_tests and "Showing test files" or "Hiding test files")
								if last_picker then
									last_picker()
								end
							end)
							return true
						end,
						file_ignore_patterns = get_file_ignore_patterns(),
						additional_args = function()
							return {
								sections = {
									{
										results = get_oldfiles_results(),
										title = "Recent Files",
										indices = {
											start = 1000,
										},
									},
								},
							}
						end,
					})
					:find()
			end
		end

		local function create_git_files_picker()
			return function()
				local pickers = require("telescope.pickers")
				local finders = require("telescope.finders")
				local conf = require("telescope.config").values
				local make_entry = require("telescope.make_entry")

				pickers
					.new({}, {
						prompt_title = "Git Files",
						finder = finders.new_oneshot_job(vim.tbl_flatten({ "git", "ls-files" }), {
							entry_maker = make_entry.gen_from_file(),
						}),
						previewer = conf.file_previewer({}),
						sorter = conf.file_sorter({}),
						attach_mappings = function(prompt_bufnr, map)
							map("i", "<C-t>", function()
								local actions = require("telescope.actions")
								actions.close(prompt_bufnr)
								show_tests = not show_tests
								vim.notify(show_tests and "Showing test files" or "Hiding test files")
								if last_picker then
									last_picker()
								end
							end)
							return true
						end,
						file_ignore_patterns = get_file_ignore_patterns(),
						additional_args = function()
							return {
								sections = {
									{
										results = get_oldfiles_results(),
										title = "Recent Files",
										indices = {
											start = 1000,
										},
									},
								},
							}
						end,
					})
					:find()
			end
		end

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-t>"] = function(prompt_bufnr)
							local actions = require("telescope.actions")
							actions.close(prompt_bufnr)
							show_tests = not show_tests
							vim.notify(show_tests and "Showing test files" or "Hiding test files")

							if last_picker then
								last_picker()
							end
						end,
					},
				},
				prompt_prefix = show_tests and "🧪 " or "  ",
			},
		})

		-- File pickers
		vim.keymap.set("n", "<leader>ff", function()
			last_picker = create_find_files_picker()
			last_picker()
		end, { desc = "Telescope - Find Files" })

		vim.keymap.set("n", "<leader>fg", function()
			last_picker = create_git_files_picker()
			last_picker()
		end, { desc = "Telescope - Git Files" })

		-- LSP pickers
		vim.keymap.set("n", "<leader>fR", builtin.lsp_references, { desc = "Telescope - References" })
		vim.keymap.set("n", "<leader>fz", builtin.lsp_workspace_symbols, { desc = "Telescope - WS Symbols" })
		vim.keymap.set("n", "<leader><leader>", builtin.lsp_document_symbols, { desc = "Telescope - Doc Symbols" })
		vim.keymap.set(
			"n",
			"<leader>fs",
			builtin.lsp_dynamic_workspace_symbols,
			{ desc = "Telescope - WS dyn Symbols" }
		)
		vim.keymap.set("n", "<leader>fd", builtin.lsp_definitions, { desc = "Telescope - Definitions" })
		vim.keymap.set("n", "<leader>fi", builtin.lsp_implementations, { desc = "Telescope - Implementations" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope - Buffers" })
		vim.keymap.set("n", "F", builtin.treesitter, { desc = "Telescope - Treesitter" })
		vim.keymap.set("n", "<leader>fr", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end, { desc = "Telescope - Grep String" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope - Help Tags" })
	end,
}
