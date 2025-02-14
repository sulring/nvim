-- Paste mappings
vim.keymap.set({ "n", "v" }, "p", '"+p', { desc = "Paste from system/OSC52 clipboard" })
vim.keymap.set({ "n", "v" }, "P", '"0p', { desc = "Paste from yank buffer" })

-- Yank mappings
vim.keymap.set({ "n", "v" }, "y", '"+y', { desc = "Yank to system/OSC52 clipboard" })
vim.keymap.set("n", "Y", '"0y$', { desc = "Yank to local buffer" })

-- Make delete operations use the black hole register
local delete_ops = { "d", "D", "x", "X", "C" }
for _, op in ipairs(delete_ops) do
    -- CHANGED: from '"_' .. op to '"0' .. op
    vim.keymap.set({ "n", "v" }, op, '"0' .. op, { desc = "Delete to register 0" })
end
