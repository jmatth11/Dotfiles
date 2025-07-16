local augroup = vim.api.nvim_create_augroup
local jmatthGroup = augroup("jmatth11", {})

require("jmatth11.set")
require("jmatth11.lazy")
require("jmatth11.telescope")

local autocmd = vim.api.nvim_create_autocmd

-- command to delete trailing spaces
autocmd({"BufWritePre"}, {
    group = jmatthGroup,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

