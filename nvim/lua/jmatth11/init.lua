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

-- lazy load clipboard to help with slowness on wsl
-- ref: https://dev.to/llllvvuu/improving-neovim-load-time-on-wsl-2-441
autocmd({ "BufReadPost", "BufNewFile" }, {
  once = true,
  callback = function()
    if vim.fn.has("win32") == 1 or vim.fn.has("wsl") == 1 then
      vim.g.clipboard = {
        copy = {
          ["+"] = "win32yank.exe -i --crlf",
          ["*"] = "win32yank.exe -i --crlf",
        },
        paste = {
          ["+"] = "win32yank.exe -o --lf",
          ["*"] = "win32yank.exe -o --lf",
        },
      }
    elseif vim.fn.has("unix") == 1 then
      if vim.fn.executable("xclip") == 1 then
        vim.g.clipboard = {
          copy = {
            ["+"] = "xclip -selection clipboard",
            ["*"] = "xclip -selection clipboard",
          },
          paste = {
            ["+"] = "xclip -selection clipboard -o",
            ["*"] = "xclip -selection clipboard -o",
          },
        }
      elseif vim.fn.executable("xsel") == 1 then
        vim.g.clipboard = {
          copy = {
            ["+"] = "xsel --clipboard --input",
            ["*"] = "xsel --clipboard --input",
          },
          paste = {
            ["+"] = "xsel --clipboard --output",
            ["*"] = "xsel --clipboard --output",
          },
        }
      end
    end

    vim.opt.clipboard = "unnamedplus"
  end,
  desc = "Lazy load clipboard",
})
