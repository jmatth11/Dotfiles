return {
  "jmatth11/time-tracker.nvim",
  lazy=false,
  init = function()
    require("time-tracker").setup()
  end,
  dependencies = {
    "nvim-lua/plenary.nvim", -- required for window management
  },
}
