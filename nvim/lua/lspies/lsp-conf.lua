-- FOR ALL LSP in neovim
-- https://github.com/neovim/nvim-lsponfig/blob/master/CONFIG.md

local lsp = require("lspconfig")
local coq = require("coq")


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    --buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    local opts = {noremap = true, silent = true}

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    buf_set_keymap("n", "<space>F", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

    vim.cmd('COQnow -s')
end

local capabilities = coq.lsp_ensure_capabilities{}

-- from vscode-langservers-extracted
lsp.html.setup {
    capabilities = capabilities,
    on_attach = on_attach
}

lsp.cssls.setup {
    capabilities = capabilities,
    on_attach = on_attach
}

lsp.jsonls.setup {
    capabilities = capabilities,
    on_attach = on_attach
}

lsp.tsserver.setup {
    capabilities = capabilities,
    on_attach = on_attach
}

lsp.rust_analyzer.setup {
    capabilities = capabilities,
    on_attach = on_attach
}

-- from
lsp.bashls.setup {
    capabilities = capabilities,
    on_attach = on_attach
}

lsp.denols.setup{
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
local system_name = "Linux"
local sumneko_root_path = "/home/kraven/Desktop/lua-lsp"
local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name .. "/lua-language-server"

-- To get builtin LSP running, do something like:
lsp.sumneko_lua.setup {
        cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
       capabilities = capabilities,
       on_attach = on_attach
}

