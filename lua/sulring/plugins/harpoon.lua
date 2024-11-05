return  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    name = "harpoon",
    dependencies = { 
        "plenary",
        "telescope",
    },
    enabled = false,
    disabled = true,
    config = function()
        local harpoon = require('harpoon')
        
        harpoon:setup({
            settings = {
                save_on_toggle = true,
                save_on_change = true,
            }
        })

        vim.keymap.set("n", "<leader>q", function() harpoon:list():add() end, { desc = " Harpoon - append"})
        vim.keymap.set("n", "<C-1>", function() harpoon:list():select(1) end, { desc = " Harpoon - 1"})
        vim.keymap.set("n", "<C-2>", function() harpoon:list():select(2) end, { desc = " Harpoon - 2"})
        vim.keymap.set("n", "<C-3>", function() harpoon:list():select(3) end, { desc = " Harpoon - 3"})
        vim.keymap.set("n", "<C-4>", function() harpoon:list():select(4) end, { desc = " Harpoon - 4"})
        vim.keymap.set("n", "<C-5>", function() harpoon:list():select(5) end, { desc = " Harpoon - 5"})
        vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = " Harpoon - 1"})
        vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = " Harpoon - 2"})
        vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = " Harpoon - 3"})
        vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = " Harpoon - 4"})
        vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end, { desc = " Harpoon - 5"})
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
        vim.keymap.set("n", "<leader><", function() harpoon:list():prev() end, { desc = " Harpoon - Prev"})
        vim.keymap.set("n", "<leader>>", function() harpoon:list():next() end, { desc = " Harpoon - Next"})

    end
}
