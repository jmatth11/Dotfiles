return {
  {
    "github/copilot.vim",
    dependencies = {
      "CopilotC-Nvim/CopilotChat.nvim",
      config = function()
        -- require("CopilotChat").setup({})
      end
    },
    enabled = (vim.fn.isdirectory("/home/jmatth93") or vim.fn.isdirectory("/home/jmatthews")) == 0
  }
}
