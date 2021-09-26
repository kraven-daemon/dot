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

---@diagnostic disable: undefined-global

-------------------- HELPERS -------------------------------
local api, cmd = vim.api, vim.cmd

-- Some safety require wrapper
local function prequire(...)
    local status, lib = pcall(require, ...)
    if (status) then return lib end
        return nil
end

-- Usefull global functions, see KEYMAPS later
function Toggle_hls()
    if api.nvim_get_option("hls") then
        api.nvim_set_option("hls", false)
    else
        api.nvim_set_option("hls", true)
    end
end

function Trim_space()
    cmd(":%s/\\s\\+$//e")
end

function _G.put(...)
  local objects = {}
  for i = 1, select('#', ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, '\n'))
  return ...
end

--[[ kinda cool wrapper around require
local function prequire(...)
local status, lib = pcall(require, ...)
if (status) then return lib end
    return nil
end
]]--

-- all public plugins and related config
prequire("packages")

-- Language server/ builtin lsp wrapper and saga
prequire("lspies.lsp-conf")
prequire("lspies.lspsaga-conf")

-- Treesitter configuration
prequire("ts-config")
-- autopairing using treesitter block scope
prequire("nvim-autopairs").setup{
    enable_check_bracket_line = false,
    ignored_next_char = "[%w%.]" -- will ignore alphanumeric and `.` symbol
}


-- about menu help: IME
-- :source $VIMRUNTIME/menu.vim
-- :set wildmenu
-- :set cpo-=<
-- :set wcm=<C-Z>
-- :map <F4> :emenu <C-Z>

-- options settings
prequire("options")
-- keybindings
prequire("mappings")
-- Status line
prequire("statusline")

prequire("auto-events")


-- Nice little rock
--require("test-fmt")
