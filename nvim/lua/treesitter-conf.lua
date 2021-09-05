--[[
https://github.com/nvim-treesitter/nvim-treesitter

]]--

require("nvim-treesitter.configs").setup {
    ensure_installed = "all",
    highlight = {enable = true},
    textobjects = {
        select = {
            enable = true
        }
    }
}
