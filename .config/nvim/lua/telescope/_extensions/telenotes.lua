local has_telescope, telescope = pcall(require, 'telescope')
if not has_telescope then
    error('This plugins requires nvim-telescope/telescope.nvim')
end

local actions = require 'telescope.actions'
local actions_set = require 'telescope.actions.set'
local conf = require'telescope.config'.values
local entry_display = require 'telescope.pickers.entry_display'
local finders = require 'telescope.finders'
local from_entry = require 'telescope.from_entry'
local make_entry = require('telescope.make_entry')
local path = require 'telescope.path'
local pickers = require 'telescope.pickers'
local previewers = require 'telescope.previewers.term_previewer'
local state = require 'telescope.state'
local utils = require 'telescope.utils'

local flatten = vim.tbl_flatten
local filter = vim.tbl_filter

local escape_chars = function(string)
    return string.gsub(string, "[%(|%)|\\|%[|%]|%-|%{%}|%?|%+|%*]", {
        ["\\"] = "\\\\",
        ["-"] = "\\-",
        ["("] = "\\(",
        [")"] = "\\)",
        ["["] = "\\[",
        ["]"] = "\\]",
        ["{"] = "\\{",
        ["}"] = "\\}",
        ["?"] = "\\?",
        ["+"] = "\\+",
        ["*"] = "\\*"
    })
end

local function set_config_state(opt_name, value, default)
    state[opt_name] = value == nil and default or value
end

local list = function(opts)
    local vimgrep_arguments = opts.vimgrep_arguments or conf.vimgrep_arguments
    local search_dirs = {state.tn_note_dir}
    local grep_open_files = opts.grep_open_files
    opts.cwd = opts.cwd and vim.fn.expand(opts.cwd) or vim.loop.cwd()

    local filelist = {}

    if grep_open_files then
        local bufnrs = filter(function(b)
            if 1 ~= vim.fn.buflisted(b) then return false end
            return true
        end, vim.api.nvim_list_bufs())
        if not next(bufnrs) then return end

        local tele_path = require 'telescope.path'
        for _, bufnr in ipairs(bufnrs) do
            local file = vim.api.nvim_buf_get_name(bufnr)
            table.insert(filelist, tele_path.make_relative(file, opts.cwd))
        end
    end

    if search_dirs then
        for i, path in ipairs(search_dirs) do
            search_dirs[i] = vim.fn.expand(path)
        end
    end

    local live_grepper = finders.new_job(
                             function(prompt)
            -- TODO: Probably could add some options for smart case and whatever else rg offers.

            if not prompt or prompt == "" then return nil end

            prompt = escape_chars(prompt)

            local search_list = {}

            if search_dirs then
                table.insert(search_list, search_dirs)
            elseif os_sep == '\\' then
                table.insert(search_list, '.')
            end

            if grep_open_files then search_list = filelist end

            return flatten {vimgrep_arguments, prompt, search_list}
        end, opts.entry_maker or make_entry.gen_from_vimgrep(opts),
                             opts.max_results, opts.cwd)

    pickers.new(opts, {
        prompt_title = 'Live Grep',
        finder = live_grepper,
        previewer = conf.grep_previewer(opts),
        sorter = conf.generic_sorter(opts)
    }):find()
end

return telescope.register_extension {
    setup = function(ext_config)
        set_config_state('tn_note_dir', ext_config.tn_note_dir, '~/.tn')
    end,
    exports = {list = list}
}
