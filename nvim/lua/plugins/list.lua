-- Plugins and luarocks imported
-- :PackerSync to trigger all steps

-- rocks to investigate
-- apparently lua-fmt pretty nice to
-- rocks = {'lpeg', {'lua-cjson', version = '2.1.0'}}
-- use_rocks {'lua-cjson', 'lua-resty-http'}
-- use_rocks {'luaformatter', server = 'https://luarocks.org/dev'}
-- use_rocks {'openssl' env = {OPENSSL_DIR = "/path/to/dir"}}

-------------------- Ensure packer is installed ------------
-- this is data directory -> XDG_DATA_HOME on xdg standards...

local fn, cmd = vim.fn, vim.cmd
local syscall = vim.fn.system

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    syscall({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
    cmd "packadd packer.nvim"
end

local packer = require('packer')
-- aliasing use to remove anoying lsp warnings of undefined global in use ...
local use = packer.use
local use_rocks = packer.use_rocks

packer.startup(
    function()
        use {"wbthomason/packer.nvim"}

        -- LSP and completion
        use {"neovim/nvim-lspconfig"}
        use {"nvim-lua/completion-nvim"}
        use "glepnir/lspsaga.nvim"
        use "windwp/nvim-autopairs"
        use "L3MON4D3/LuaSnip"

        -- Lua development
        use {"tjdevries/nlua.nvim"}

        -- Vim dispatch
        use {"tpope/vim-dispatch"}

        -- Fugitive for Git
        use {"tpope/vim-fugitive"}

        -- Syntax and Treesitter
        use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"} -- trigger update on :PackerSync
        use "nvim-treesitter/playground"
        use "sheerun/vim-polyglot"
        -- 3 in 1 , plenary(set of functions), popup(vimbuffer overlay boxes) and telescope(fuzzy finder)
        use {
            "nvim-telescope/telescope.nvim",
            requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}}
        }

        -- Candy
        use {"hoob3rt/lualine.nvim", requires = {"kyazdani42/nvim-web-devicons", opt = true}}
        use {"kyazdani42/nvim-tree.lua", requires = {"kyazdani42/nvim-web-devicons", opt = true}}
        use {"PyGamer0/darc.nvim", requires = {"rktjmp/lush.nvim"}}

        -- rocks test
        use_rocks {"lua-fmt", server = 'https://luarocks.org/dev'}
    end
)
