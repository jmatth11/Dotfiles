local nnoremap = require("jmatth11.keymap").nnoremap

return {
  --dir = "/home/jmatth11/git/jmatth11/player.nvim",
  dir = "/home/jmatthews/git/jmatth11/player.nvim",
  build = "zig build",
  config = function()
    require("player").setup({parent_dir = vim.env.HOME .. "/music", recursive = true})
    nnoremap("<leader>pp", ":lua require('player').player_info()<CR>")
    nnoremap("<leader>pf", ":lua require('player').file_select()<CR>")
  end,
  dependencies = {
    "nvim-lua/plenary.nvim", -- required for window management
  },
}
