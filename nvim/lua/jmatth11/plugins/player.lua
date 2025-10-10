return {
  "jmatth11/player.nvim",
  --dir = "/home/jmatth11/git/jmatth11/player.nvim",
  build = "zig build",
  config = true,
  opts = {
    parent_dir = vim.env.HOME .. "/music",
    recursive = true,
  },
  dependencies = {
    "nvim-lua/plenary.nvim", -- required for window management
  },
  lazy = true,
}
