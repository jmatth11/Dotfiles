return {
  {
    "github/copilot.vim",
    dependencies = {
      "CopilotC-Nvim/CopilotChat.nvim",
      config = function()
        require("CopilotChat").setup({})
      end
    },
  }
}
