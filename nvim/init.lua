-- Some things to look out
--   lua-fmt: https://github.com/trixnz/lua-fmt
--   Lualine: https://github.com/hoob3rt/lualine.nvim
--   Galaxyline: https://github.com/glepnir/galaxyline...
--   Minimap: https://github.com/wfxr/minimap.vim
--   nvim-compe: https://github.com/hrsh7th/nvim-compe
--   Formatter: https://github.com/mhartington/format...
--   Telescope: https://github.com/nvim-telescope/tel...
--   Hop: https://github.com/phaazon/hop.nvim
--
-- Neovim resources
--
--   On using Quickfix list with Telescope: https://github.com/nvim-lua/wishlist/...
--   Neovim discourse: https://neovim.discourse.group
--   ThePrimeagen: https://www.youtube.com/c/ThePrimeagen – not just an informative YouTube channel; also hilarious!
--   Neovim (0.5) Is Overpowering: https://crispgm.com/page/neovim-is-ov... – was the blog post I read that prompted me to take another look at Neovim

--[[
    for lsp https://neovim.io/doc/user/lsp.html
]]--

-------------------- HELPERS -------------------------------
local api, cmd, fn, g = vim.api, vim.cmd, vim.fn, vim.g
local opt, wo = vim.opt, vim.wo
local fmt = string.format
local syscall = vim.fn.system -- to make a shell system call

-- Function that map keys
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true, silent = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Usefull global functions, see KEYMAPS later
function Toggle_hls()
    if api.nvim_get_option('hls') then
        api.nvim_set_option('hls', false)
    else
        api.nvim_set_option('hls', true)
    end
end

function Trim_space()
    vim.cmd(':%s/\\s\\+$//e')
end

-------------------- Ensure packer is installed ------------
-- this is data directory -> XDG_DATA_HOME on xdg standards...
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  syscall({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  cmd 'packadd packer.nvim'
end

-------------------- PLUGINS -------------------------------
require('packer').startup(function()
    use {'wbthomason/packer.nvim' }

    -- LSP and completion
    use { 'neovim/nvim-lspconfig' }
    use { 'nvim-lua/completion-nvim' }
    use 'glepnir/lspsaga.nvim'
    use 'windwp/nvim-autopairs'
    use 'L3MON4D3/LuaSnip'

    -- Lua development
    use { 'tjdevries/nlua.nvim' }

    -- Vim dispatch
    use { 'tpope/vim-dispatch' }

    -- Fugitive for Git
    use { 'tpope/vim-fugitive' }

    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-treesitter/playground'

    -- 3 in 1 , plenary(set of functions), popup(vimbuffer overlay boxes) and telescope(fuzzy finder)
    use { 'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
	}

    -- Candy
    use { 'hoob3rt/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true } }
    use { 'kyazdani42/nvim-tree.lua', requires = {'kyazdani42/nvim-web-devicons', opt = true} }
    use { 'PyGamer0/darc.nvim', requires = {'rktjmp/lush.nvim'} }
end)

-------------------- OPTIONS -------------------------------
--  for more info
--  :set all -->


local indent = 4
-- opt.colorcolumn = tostring(width)   -- Line length marker
-- opt.textwidth = width               -- Maximum width of text
opt.completeopt = {'menuone', 'noselect'}  -- Completion options
opt.cursorline = true               -- Highlight cursor line
opt.expandtab = true                -- Use spaces instead of tabs
opt.formatoptions = 'crqnj'         -- Automatic formatting options
opt.hidden = true                   -- Enable background buffers
opt.ignorecase = true               -- Ignore case
opt.joinspaces = false              -- No double spaces with join
opt.list = true                     -- Show some invisible characters
opt.number = true                   -- Show line numbers
opt.pastetoggle = '<F2>'            -- Paste mode
opt.relativenumber = true           -- Relative line numbers
opt.scrolloff = 4                   -- Lines of context
opt.shiftround = true               -- Round indent
opt.shiftwidth = indent             -- Size of an indent
opt.sidescrolloff = 8               -- Columns of context
opt.signcolumn = 'yes'              -- Show sign column
opt.smartcase = true                -- Do not ignore case with capitals
opt.smartindent = true              -- Insert indents automatically
opt.splitbelow = true               -- Put new windows below current
opt.splitright = true               -- Put new windows right of current
opt.tabstop = indent                -- Number of spaces tabs count for
opt.termguicolors = true            -- True color support
opt.updatetime = 100                -- Delay before swap file is saved
opt.wildmode = {'longest', 'full'}  -- Command-line completion mode
opt.wrap = false                    -- Disable line wrap
opt.mouse = 'a'
cmd 'colorscheme darc'


-------------------- TREE-SITTER ---------------------------
require('nvim-treesitter.configs').setup {
  ensure_installed = 'all',
  highlight = {enable = true},
  textobjects = {
    select = {
      enable = true,
    },

  },
}

-------------------- LSP -------------------------------------
-- FOR ALL LSP in neovim
-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md

local lspc = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>F', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  require('completion').on_attach()
end


--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- from vscode-langservers-extracted
lspc.html.setup {
   capabilities = capabilities,
   on_attach = on_attach
}

lspc.cssls.setup {
   capabilities = capabilities,
   on_attach = on_attach
}

lspc.jsonls.setup {
   capabilities = capabilities,
   on_attach = on_attach
}

lspc.tsserver.setup{
   capabilities = capabilities,
   on_attach = on_attach
}


lspc.rust_analyzer.setup{
    capabilities = capabilities,
    on_attach = on_attach
}

-- from 
lspc.bashls.setup{
    capabilities = capabilities,
    on_attach = on_attach
}

-------------------------------------------------------
---   _    _   _   _
--   | |  | | | | / \          _                 _
--   | |  | | | |/ _ \        ( \.-------------./ )
--   | |__| |_| / ___ \        \(    EAT IT!    )/
---  |_____\___/_/   \_\         `.___________.'
-------------------------------------------------------

-- set the path to the sumneko installation
local system_name = "Linux" -- (Linux, macOS, or Windows)
local sumneko_root_path = '/home/kraven/Desktop/lua-lsp'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

-- To get builtin LSP running, do something like:
-- NOTE: This replaces the calls where you would have before done `require('nvim_lsp').sumneko_lua.setup()`
require('nlua.lsp.nvim').setup(require('lspconfig'), {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    -- An example of settings for an LSP server.
    --    For more options, see nvim-lspconfig
    settings = {
        Lua = {
            runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
            -- Setup your lua path
            path = vim.split(package.path, ';'),
            },
            diagnostics = {
            -- Include globals you want to tell the LSP are real :)
            globals = { "use" },
            },
            workspace = {
            -- Make the server aware of Neovim runtime files
                library = {
                    [fn.expand('$VIMRUNTIME/lua')] = true,
                    [fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                },
            },
        }
    },
    capabilities = capabilities,
    on_attach = on_attach
})

--- KEYMAP

g.mapleader = " "
-- map('n', '<leader>f', ':Lexplore<CR> :vertical resize 33%<CR>')
map('n', '<leader>f', ':NvimTreeToggle<CR>')
map('n', '<leader>h', ':lua Toggle_hls()<CR>')
map('n', '<leader>w', ':lua Trim_space()<CR>')


-- Primeagen's top 5, you're so right :D
-- "If you press that P, you get exactly what you wanted from that P"
-- like D,C relative yanking to cursor position to \n
map('n', 'Y', 'y$')

-- Keeping it centered, when moving in search or joining lines
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', 'J', 'mzJ`zzz')

-- Undo breakpoints, pretty usefull

map('i', ',', ',<c-g>u')
map('i', '.', '.<c-g>u')
map('i', '!', '!<c-g>u')
map('i', '?', '?<c-g>u')

-- relative jumping( like 15j or 15k) doesn't count in history jumping
-- history jumping is when
-- <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
-- <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

-- move line[s] like a champ
map('n', '<leader>k', ':m .-2<CR>==')
map('n', '<leader>j', ':m .+1<CR>==')
map('i', '<C-k>', '<esc>:m .-2<CR>')
map('i', '<C-j>', '<esc>:m .+1<CR>')
map('v', 'K', ':m \'<-2<CR>gv=gv')
map('v', 'J', ':m \'>+1<CR>gv=gv')


--- LSP SAGA BLING BLING
local saga = require 'lspsaga'
--saga.init_lsp_saga {
--  your custom option here
--}
--use default config
saga.init_lsp_saga()


-- Status line
local lualine = require 'lualine'
local line_config = {
    options = {
        theme = 'molokai',
        section_separators = {'$', '<'},
        component_separators = {'', ''}
    }
}
lualine.setup(line_config)


--[[ kinda cool wrapper around require
local function prequire(...)
local status, lib = pcall(require, ...)
if (status) then return lib end
    return nil
end
]]--

require('nvim-autopairs').setup{}
