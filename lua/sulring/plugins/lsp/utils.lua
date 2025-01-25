local M = {}

-- Shared capabilities for all LSP servers
M.capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Enhanced capabilities for TypeScript
M.typescript_capabilities = vim.tbl_deep_extend("force", M.capabilities, {
	documentFormattingProvider = false, -- We'll use prettier for formatting
	documentRangeFormattingProvider = false,
})

-- Attach function for LSP
M.on_attach = function(client, bufnr)
	-- Load keymaps
	local keymaps = require("sulring.plugins.lsp.keymaps")
	keymaps(client, bufnr)

	-- Enable completion triggered by <c-x><c-o>
	vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

	-- Configure highlight groups for LSP references
	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
		vim.api.nvim_create_autocmd("CursorHold", {
			group = "lsp_document_highlight",
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			group = "lsp_document_highlight",
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end

	-- Special handling for TypeScript files
	if client.name == "typescript-tools" then
		-- Configure additional TypeScript-specific features here
		vim.api.nvim_buf_create_user_command(bufnr, "TSOrganizeImports", "TSToolsOrganizeImports", {})
		vim.api.nvim_buf_create_user_command(bufnr, "TSFixAll", "TSToolsFixAll", {})
	end
end

-- Helper function to filter diagnostics
M.filter_diagnostics = function(diagnostics_list)
	return function(_, result, ctx, config)
		if result.diagnostics then
			local filtered_diagnostics = vim.tbl_filter(function(diagnostic)
				return not vim.tbl_contains(diagnostics_list, diagnostic.code)
			end, result.diagnostics)
			result.diagnostics = filtered_diagnostics
		end
		vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
	end
end

return M
