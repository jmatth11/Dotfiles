local nnoremap = require("jmatth11.keymap").nnoremap

nnoremap("<leader>ff", function() require("telescope.builtin").find_files() end)
nnoremap("<leader>fg", function() require("telescope.builtin").live_grep() end)
nnoremap("<leader>fb", function() require("telescope.builtin").buffers() end)
nnoremap("<leader>fh", function() require("telescope.builtin").help_tags() end)

nnoremap("<leader>fw", function()
    require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>")})
end)
