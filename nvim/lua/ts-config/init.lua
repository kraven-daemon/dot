--[[
https://github.com/nvim-treesitter/nvim-treesitter

]]--

require("nvim-treesitter.configs").setup {
    ensure_installed = { "bash",
                         "lua"
    },
    highlight = {enable = true},
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<c-n>",
            node_incremental = "<c-n>",
            scope_incremental = "<c-s>",
            node_decremental = "<c-m>",
      },

    },
    indent = {
        enable = true,
    },
    textobects = {
        select = {
            enable = true
        }
    },
    -- disable :syntax from vim
    additional_vim_regex_highlighting = false,
}
