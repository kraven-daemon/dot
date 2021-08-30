--[[
nvim/lua resources
    https://github.com/nanotee/nvim-lua-guide
    :help 'runtimepath'
    :help load-plugins
    :help :lua
    :help :lua-heredoc
]]--


--[[
Directory that can load lua files
in XDG_CONFIG_HOME/nvim/ or any runtimepaths

    colors/
    compiler/
    ftplugin/
    ftdetect/
    indent/
    plugin/
    syntax/

]]--

-------------------- HELPERS -------------------------------
local api, cmd, fn, g = vim.api, vim.cmd, vim.fn, vim.g
local opt, wo = vim.opt, vim.wo


-- Usefull global functions, see KEYMAPS later
function Toggle_hls()
    if api.nvim_get_option("hls") then
        api.nvim_set_option("hls", false)
    else
        api.nvim_set_option("hls", true)
    end
end

function Trim_space()
    vim.cmd(":%s/\\s\\+$//e")
end

--[[ kinda cool wrapper around require
local function prequire(...)
local status, lib = pcall(require, ...)
if (status) then return lib end
    return nil
end
]]--

-- all public plugins and related config
require("plugins")
-- vim editor options
require("options")
-- remapings
require("controls")

-- Status line
require("evil_lualine")

-- some additions
require("nvim-autopairs").setup{}

