local nnoremap = require("jmatth11.keymap").nnoremap

return {
  --dir = "/home/jmatth11/git/jmatth11/player.nvim",
  dir = "/home/jmatthews/git/jmatth11/player.nvim",
  build = "zig build",
  config = function()
    require("player").setup({parent_dir = "/home/jmatthews/git/jmatth11/player.nvim/test"})
    nnoremap("<leader>pp", ":lua require('player').player_info()<CR>")
  end,
  dependencies = {
    "nvim-lua/plenary.nvim", -- required for window management
  },
}
