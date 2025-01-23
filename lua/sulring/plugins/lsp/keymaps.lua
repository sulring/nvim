return function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    local keymap = vim.keymap.set

    -- General LSP keymaps
    keymap("n", "gD", vim.lsp.buf.declaration, opts)
    keymap("n", "gd", vim.lsp.buf.definition, opts)
    keymap("n", "gi", vim.lsp.buf.implementation, opts)
    keymap("n", "K", vim.lsp.buf.hover, opts)
    keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename", buffer = bufnr })
    keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action", buffer = bufnr })
    keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic", buffer = bufnr })
    keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic", buffer = bufnr })
    keymap("n", "<leader>e", vim.diagnostic.open_float, { desc = "Float Diagnostic", buffer = bufnr })
    keymap("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic List", buffer = bufnr })

    -- TypeScript specific keymaps (only loaded when typescript-tools is the active client)
    if client.name == "typescript-tools" then
        -- Import management
        keymap("n", "<leader>co", "<cmd>TSToolsOrganizeImports<cr>", 
            { desc = "Organize Imports", buffer = bufnr })
        keymap("n", "<leader>cs", "<cmd>TSToolsSortImports<cr>", 
            { desc = "Sort Imports", buffer = bufnr })
        keymap("n", "<leader>cu", "<cmd>TSToolsRemoveUnusedImports<cr>", 
            { desc = "Remove Unused Imports", buffer = bufnr })
        
        -- Code management
        keymap("n", "<leader>cU", "<cmd>TSToolsRemoveUnused<cr>", 
            { desc = "Remove Unused Statements", buffer = bufnr })
        keymap("n", "<leader>ci", "<cmd>TSToolsAddMissingImports<cr>", 
            { desc = "Add Missing Imports", buffer = bufnr })
        keymap("n", "<leader>cf", "<cmd>TSToolsFixAll<cr>", 
            { desc = "Fix All", buffer = bufnr })
        
        -- Navigation
        keymap("n", "<leader>cg", "<cmd>TSToolsGoToSourceDefinition<cr>", 
            { desc = "Go To Source Definition", buffer = bufnr })
        keymap("n", "<leader>cR", "<cmd>TSToolsRenameFile<cr>", 
            { desc = "Rename File", buffer = bufnr })
        keymap("n", "<leader>cr", "<cmd>TSToolsFileReferences<cr>", 
            { desc = "File References", buffer = bufnr })
    end
end
