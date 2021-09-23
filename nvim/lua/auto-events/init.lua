-- Terminal buffer with no decoration
local cmd = vim.api.nvim_command

-- Futureme : try to hide status line or something
-- laststatus=0 statusline=

cmd([[
    autocmd TermOpen * setlocal nonumber norelativenumber foldcolumn=0 signcolumn=no "
]])


