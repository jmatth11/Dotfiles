local augroup = vim.api.nvim_create_augroup
local jmatthGroup = augroup("jmatth11", {})

require("jmatth11.set")
require("jmatth11.lazy")
require("jmatth11.telescope")

local project_file = vim.fn.getcwd() .. '/project.godot'
if vim.fn.filereadable(project_file) == 1 then
  local pipe = [[\\.\pipe\godot.pipe]]
  local sys_info = vim.uv.os_uname()
  if sys_info["sysname"] == "Linux" then
    pipe = "/tmp/godot.pipe"
  end
  vim.fn.serverstart(pipe)
end

local autocmd = vim.api.nvim_create_autocmd

-- command to delete trailing spaces
autocmd({"BufWritePre"}, {
    group = jmatthGroup,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

