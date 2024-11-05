return {
	{ "VonHeikemen/lsp-zero.nvim", branch = "v4.x" },
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lsp_zero = require("lsp-zero")

			-- lsp_attach is where you enable features that only work
			-- if there is a language server active in the file
			local lsp_attach = function(client, bufnr)
				local opts = { buffer = bufnr }

				vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
				vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts)
				vim.keymap.set("n", "gD", "<cmd>Telescope lsp_declarations<cr>", opts)
				vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts)
				vim.keymap.set("n", "go", "<cmd>Telescope lsp_type_definitions<cr>", opts)
				vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
				vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
				vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
				vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
				vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
			end

			lsp_zero.extend_lspconfig({
				sign_text = true,
				lsp_attach = lsp_attach,
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})
			require("lspconfig").rust_analyzer.setup({
				settings = {
					["rust-analyzer"] = {
						diagnostics = {
							enable = false,
						},
					},
				},
			})
			require("lspconfig").zls.setup({})
			require("lspconfig").pyright.setup({
				python = {
					analysis = {
						autoSearchPaths = true,
						diagnosticMode = "openFilesOnly",
						useLibraryCodeForTypes = true,
					},
				},
			})
			require("lspconfig").marksman.setup({})
			require("lspconfig").lua_ls.setup({
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})
			require("lspconfig").tsserver.setup({
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
				},
				root_dir = function(fname)
					return require("lspconfig").util.root_pattern("tsconfig.json")(fname)
						or require("lspconfig").util.root_pattern("package.json", "jsconfig.json", ".git")(fname)
				end,
				on_new_config = function(new_config, new_root_dir)
					new_config.filetypes = vim.tbl_filter(function(ft)
						return not vim.endswith(ft, ".mts")
					end, new_config.filetypes)
				end,
			})
		end,
	},
	{ "hrsh7th/cmp-nvim-lsp" },
	{
		"hrsh7th/cmp-nvim-lsp-signature-help",
		name = "sig_help",
	},
	{ "hrsh7th/cmp-path" },
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
					{ name = "sig_help" },
					{ name = "path" },
					-- { name = "minuet", group_index = 1, priority = 100 },
				},
				performance = {
					fetching_timeout = 2000,
				},
				window = {
					completion = cmp.config.window.bordered({
						winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:CmpPmenuSel,Search:None",
					}),
				},
				formatting = {
					format = function(entry, vim_item)
						vim_item.menu = ({
							minuet = "󱗻",
						})[entry.source.name]
						return vim_item
					end,
				},
				experimental = {
					ghost_text = true,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-t>"] = cmp.mapping(function()
						cmp.setup.window.completion.offset = {
							row = cmp.config.window.completion.offset.row * -1,
							col = 0,
						}
					end),
					["<C-a>"] = require("minuet").make_cmp_map(),

					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<CR>"] = cmp.mapping.confirm({ select = true }),

					["<Up>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.close()
						end
						fallback()
					end, { "i", "s" }),
					["<Down>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.close()
						end
						fallback()
					end, { "i", "s" }),
					["<Left>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.close()
						end
						fallback()
					end, { "i", "s" }),
					["<Right>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.close()
						end
						fallback()
					end, { "i", "s" }),

					["k"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.close()
						end
						fallback()
					end, { "i", "s" }),
					["j"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.close()
						end
						fallback()
					end, { "i", "s" }),
					["h"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.close()
						end
						fallback()
					end, { "i", "s" }),
					["l"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.close()
						end
						fallback()
					end, { "i", "s" }),
				}),
			})
		end,
	},
	{
		dir = "/home/sulring/dev/minuet-ai.nvim",
		priority = 1000,
		dev = true,
		name = "minuet",
		config = function()
			local default_prompt = [[
You are the backend of an AI-powered code completion engine. Your task is to
provide code suggestions based on the user's input. The user's code will be
enclosed in markers:

- `<contextAfterCursor>`: Code context after the cursor
- `<cursorPosition>`: Current cursor location
- `<contextBeforeCursor>`: Code context before the cursor

Note that the user's code will be prompted in reverse order: first the code
after the cursor, then the code before the cursor.
]]

			local default_guidelines = [[
Guidelines:
1. Offer completions after the `<cursorPosition>` marker.
2. Make sure you have maintained the user's existing whitespace and indentation.
   This is REALLY IMPORTANT!
3. Provide multiple completion options when possible.
4. Return completions separated by the marker <endCompletion>.
5. The returned message will be further parsed and processed. DO NOT include
   additional comments or markdown code block fences. Return the result directly.
6. Keep each completion option concise, limiting it to a single line or a few lines.]]

			local default_fewshots = {
				{
					role = "user",
					content = [[
# language: python
<contextAfterCursor>

fib(5)
<contextBeforeCursor>
def fibonacci(n):
    <cursorPosition>]],
				},
				{
					role = "assistant",
					content = [[
    '''
    Recursive Fibonacci implementation
    '''
    if n < 2:
        return n
    return fib(n - 1) + fib(n - 2)
<endCompletion>
    '''
    Iterative Fibonacci implementation
    '''
    a, b = 0, 1
    for _ in range(n):
        a, b = b, a + b
    return a
<endCompletion>
]],
				},
			}

			local n_completion_template = "7. Provide at most %d completion items."

			local default_system_template = "{{{prompt}}}\n{{{guidelines}}}\n{{{n_completion_template}}}"

			local default_system = {
				template = default_system_template,
				prompt = default_prompt,
				guidelines = default_guidelines,
				n_completion_template = n_completion_template,
			}

			-- Include the defined defaults in the OpenAI-compatible setup
			require("minuet").setup({
				enabled = true,
				provider = "openai_compatible",
				context_window = 12800,
				context_ratio = 0.75,
				throttle = 1000,
				debounce = 400,
				notify = "verbose",
				request_timeout = 3,
				add_single_line_entry = false,
				n_completions = 3,
				after_cursor_filter_length = 15,
				provider_options = {
					openai_compatible = {
						model = "openai/gpt-4o-mini",
						system = default_system,
						few_shots = default_fewshots,
						end_point = "https://openrouter.ai/api/v1/chat/completions",
						api_key = "OPENROUTER_API_KEY",
						name = "Aura",
						stream = false,
						optional = {
							stop = nil,
							max_tokens = nil,
						},
					},
				},
			})
		end,
	},
}
