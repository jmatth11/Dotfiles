local augroup = vim.api.nvim_create_augroup
local jmatthGroup = augroup("jmatth11", {})

require("jmatth11.set")
require("jmatth11.packer")
require("jmatth11.telescope")

local autocmd = vim.api.nvim_create_autocmd

autocmd({"BufWritePre"}, {
    group = jmatthGroup,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

