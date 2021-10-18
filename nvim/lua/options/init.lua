-- Vim global options configuration
---@diagnostic disable: undefined-global
local opt = vim.opt
local cmd = vim.cmd

-------------------- OPTIONS -------------------------------
--  :set all --> for info

-- Folding with treesitter
opt.foldenable = false
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.fillchars = "fold: ,foldclose:*,foldopen:>,foldsep:|"

-- Invisible caracters
opt.list = true

-- Left side
opt.foldcolumn = "2"
opt.signcolumn = "number" -- Show sign info on number column
opt.number = true -- Show line numbers
opt.relativenumber = true -- Relative line numbers
opt.numberwidth = 5

-- opt.colorcolumn = tostring(width)   -- Line length marker for python, mostly..
-- opt.textwidth = width               -- Maximum width of text
opt.completeopt = {"menuone", "noselect"} -- Completion options
opt.cursorline = true -- Highlight cursor line

-- Indent and shift
local indent = 4
opt.tabstop = indent -- Number of spaces tabs count for
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftround = true -- Round indent
opt.shiftwidth = indent -- Size of an indent
opt.smartindent = true -- Insert indents automatically

-- Other
opt.formatoptions = "crqnj" -- Automatic formatting options
opt.hidden = true -- Enable background buffers
opt.ignorecase = true -- Ignore case
opt.joinspaces = false -- No double spaces with join
opt.pastetoggle = "<F2>" -- Paste mode
opt.scrolloff = 4 -- Lines of context
opt.sidescrolloff = 8 -- Columns of context
opt.smartcase = true -- Do not ignore case with capitals
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.termguicolors = true -- True color support
opt.updatetime = 100 -- Delay before swap file is saved
opt.wildmode = {"longest", "full"} -- Command-line completion mode
opt.wrap = false -- Disable line wrap
opt.mouse = "a"
cmd "colorscheme chucky-theme"

