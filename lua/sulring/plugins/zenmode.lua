return {
    {
        "folke/zen-mode.nvim",
        opts = {
            window = {
                backdrop = 0.90,
                width = 120,
                height = 1,
                options = {
                    signcolumn = "yes",
                },
            },
            plugins = {
                wezterm = {
                    enabled = true,
                    -- can be either an absolute font size or the number of incremental steps
                    font = "+4", -- (10% increase per step)
                },
            }
        }
    }
}
