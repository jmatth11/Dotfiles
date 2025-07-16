local nnoremap = require("jmatth11.keymap").nnoremap

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-lua/popup.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
      },
      "BurntSushi/ripgrep",
    },
    config = function()
      nnoremap("<leader>ff", function() require("telescope.builtin").find_files() end)
      nnoremap("<leader>fg", function() require("telescope.builtin").live_grep() end)
      nnoremap("<leader>fb", function() require("telescope.builtin").buffers() end)
      nnoremap("<leader>fh", function() require("telescope.builtin").help_tags() end)

      nnoremap("<leader>fw", function()
          require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>")})
      end)
    end,
  }
}
