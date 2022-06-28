local nnoremap = require("jmatth11.keymap").nnoremap

local silent = { silent = true }

nnoremap("<leader>ht", function() require("harpoon.ui").toggle_quick_menu() end, silent)
nnoremap("<leader>hm", function() require("harpoon.mark").add_file() end, silent)
nnoremap("<leader>hc", function() require("harpoon.mark").clear_all() end, silent)
