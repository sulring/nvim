local M = {}

local config_path = vim.fn.stdpath("config")
local osc_config_file = config_path .. "/osc52_config.json"
local osc52 = require("vim.ui.clipboard.osc52")

local function encode_for_osc52(text)
    return vim.fn.system("base64", text):gsub("\n", "")
end

local function send_osc52(text)
    local encoded = encode_for_osc52(text)
    local osc = string.format('\x1b]52;c;%s\x07', encoded)
    io.stdout:write(osc)
    io.stdout:flush()
end

local function load_osc52_state()
    local file = io.open(osc_config_file, "r")
    if file then
        local content = file:read("*all")
        file:close()
        local status = vim.json.decode(content)
        return status and status.enabled or false
    end
    return false
end

local function save_osc52_state(enabled)
    local file = io.open(osc_config_file, "w")
    if file then
        file:write(vim.json.encode({ enabled = enabled }))
        file:close()
    end
end

function M.toggle_osc52()
    vim.g.osc52_enabled = not vim.g.osc52_enabled
    save_osc52_state(vim.g.osc52_enabled)
    vim.notify(vim.g.osc52_enabled and "OSC52 clipboard enabled" or "OSC52 clipboard disabled")
end

vim.g.osc52_enabled = load_osc52_state()

vim.g.clipboard = {
    name = "custom",
    copy = {
        ["+"] = function(lines)
            local text = table.concat(lines, "\n")
            if vim.g.osc52_enabled then
                send_osc52(text)
            end
            -- Always set system registers as fallback
            vim.fn.setreg("+", text)
            vim.fn.setreg("*", text)
        end,
        ["*"] = function(lines)
            local text = table.concat(lines, "\n")
            if vim.g.osc52_enabled then
                send_osc52(text)
            end
            vim.fn.setreg("+", text)
            vim.fn.setreg("*", text)
        end,
    },
    paste = {
        ["+"] = function()
            local reg = vim.fn.getreg("+")
            local regtype = vim.fn.getregtype("+")
            return vim.fn.split(reg, "\n"), regtype
        end,
        ["*"] = function()
            local reg = vim.fn.getreg("*")
            local regtype = vim.fn.getregtype("*")
            return vim.fn.split(reg, "\n"), regtype
        end,
    },
}

return M
