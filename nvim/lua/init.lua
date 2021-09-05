-- a list of all that packer is requiring
local function prequire(...)
    local status, lib = pcall(require, ...)
    if (status) then return lib end
        return nil
end

require("pkgs")
-- configuration for each separated plugin
require("treesitter-conf")
require("lsp-conf")
require("lspsaga-conf")
