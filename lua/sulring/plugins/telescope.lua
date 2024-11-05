return {
    "nvim-telescope/telescope.nvim",
    branch = '0.1.x',
    name = "telescope",
    dependencies = {
        'plenary',
    },
    config = function()
        require('telescope').setup({})
        local builtin = require("telescope.builtin")
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {  desc = "Telescope - Find Files"  })
        vim.keymap.set('n', '<leader>fg', builtin.git_files, {  desc = "Telescope - Git Files"  })
        vim.keymap.set('n', '<leader>R', builtin.lsp_references, {  desc = "Telescope - References"  })
        vim.keymap.set('n', '<leader><leader>', builtin.lsp_workspace_symbols, {  desc = "Telescope - WS Symbols"  })
        vim.keymap.set('n', '<leader>s', builtin.lsp_document_symbols, {  desc = "Telescope - Doc Symbols"  })
        vim.keymap.set('n', '<leader>Z', builtin.lsp_dynamic_workspace_symbols, {  desc = "Telescope - WS dyn Symbols"  })
        vim.keymap.set('n', '<leader>d', builtin.lsp_definitions, {  desc = "Telescope - Definitions"  })
        vim.keymap.set('n', '<leader>I', builtin.lsp_implementations, {  desc = "Telescope - Implementations"  })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {  desc = "Telescope - Buffers"  })
        vim.keymap.set('n', 'F', builtin.treesitter, {  desc = "Telescope - Treesitter"  })

        vim.keymap.set(
            'n', '<leader>fr',
            function()
                builtin.grep_string({ search = vim.fn.input("Grep >") })
            end,
            {  desc = "Telescope - Grep String"  })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {  desc = "Telescope - Help Tags"  })

    end
}
