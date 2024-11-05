
local Path = require('plenary.path')

-- Function to get the workspace-specific history file path in ~/.nvim
local function get_history_file_path()
    local home = vim.fn.expand("~")
    local nvim_dir = Path:new(home, '.nvim')
    if not nvim_dir:exists() then
        nvim_dir:mkdir()
    end
    local workspace_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
    return Path:new(nvim_dir, workspace_name .. '_replace_history.json'):absolute()
end

-- Function to load history from file
local function load_history()
    local file_path = get_history_file_path()
    if Path:new(file_path):exists() then
        local content = Path:new(file_path):read()
        if content then
            _G.replacement_history = vim.fn.json_decode(content)
        else
            _G.replacement_history = {}
        end
    else
        _G.replacement_history = {}
    end
end

-- Function to save history to file
local function save_history()
    local file_path = get_history_file_path()
    Path:new(file_path):write(vim.fn.json_encode(_G.replacement_history), 'w')
end

-- Load history when Neovim starts
load_history()

-- Define the custom command
vim.cmd([[
  command! -range -nargs=1 ReplaceSelectionGlobal <line1>,<line2>lua ReplaceSelectionGlobalFunc(<f-args>)
]])

-- Define the function to handle the replacement
function ReplaceSelectionGlobalFunc(replacement)
    local saved_reg = vim.fn.getreg('"')
    vim.cmd('normal! gv"ay')
    local pattern = vim.fn.escape(vim.fn.getreg('a'), '/\\&~')
    
    -- Save the replacement to history regardless of execution
    table.insert(_G.replacement_history, 1, {from = pattern, to = replacement})
    save_history()
    
    -- Perform the replacement with confirmation for each occurrence
    vim.cmd(string.format('%%s/%s/%s/gc', pattern, replacement))
    
    vim.fn.setreg('"', saved_reg)
end

-- Function to repeat the last replacement
function RepeatLastReplacement()
    if #_G.replacement_history > 0 then
        local last = _G.replacement_history[1]
        vim.cmd(string.format('%%s/%s/%s/gc', last.from, last.to))
    else
        print("No previous replacement to repeat")
    end
end

-- Function to delete an entry from the history
local function delete_history_entry(index)
    table.remove(_G.replacement_history, index)
    save_history()
end

-- Function to clear the entire history
local function clear_history()
    _G.replacement_history = {}
    save_history()
    print("Replacement history cleared")
end

-- Function to show replacement history using Telescope
 function ShowReplacementHistory()
    if #_G.replacement_history == 0 then
        print("No replacement history available.")
        return
    end
    
    local pickers = require "telescope.pickers"
    local finders = require "telescope.finders"
    local conf = require("telescope.config").values
    local actions = require "telescope.actions"
    local action_state = require "telescope.actions.state"

    pickers.new({}, {
        prompt_title = "Replacement History",
        finder = finders.new_table {
            results = _G.replacement_history,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry.from .. " -> " .. entry.to,
                    ordinal = entry.from .. " " .. entry.to,
                }
            end
        },
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                vim.cmd(string.format('%%s/%s/%s/gc', selection.value.from, selection.value.to))
            end)
            
            -- Add mapping to delete the selected entry
            map('i', '<C-d>', function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                -- Find and remove the selected entry
                for i, entry in ipairs(_G.replacement_history) do
                    if entry.from == selection.value.from and entry.to == selection.value.to then
                        table.remove(_G.replacement_history, i)
                        break
                    end
                end
                save_history()
                ShowReplacementHistory()
            end)

            -- Add mapping to clear the entire history
            map('i', '<C-x>', function()
                actions.close(prompt_bufnr)
                clear_history()
            end)

            return true
        end,
    }):find()
end  

-- Map <leader><C-r> to the custom command in visual mode
vim.api.nvim_set_keymap('v', '<leader><C-r>', ':ReplaceSelectionGlobal ', { noremap = true })

-- Map <leader><C-r> in normal mode to repeat the last replacement
vim.api.nvim_set_keymap('n', '<leader><C-R>', ':lua RepeatLastReplacement()<CR>', { noremap = true })

-- Map <leader><C-H> in normal mode to show replacement history using Telescope
vim.api.nvim_set_keymap('n', '<leader><C-H>', ':lua ShowReplacementHistory()<CR>', { noremap = true })
