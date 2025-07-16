local nnoremap = require("jmatth11.keymap").nnoremap

return {
  "ThePrimeagen/harpoon",
  config = function()
    local silent = { silent = true }

    nnoremap("<leader>ht", function() require("harpoon.ui").toggle_quick_menu() end, silent)
    nnoremap("<leader>hm", function() require("harpoon.mark").add_file() end, silent)
    nnoremap("<leader>hc", function() require("harpoon.mark").clear_all() end, silent)
  end
}
