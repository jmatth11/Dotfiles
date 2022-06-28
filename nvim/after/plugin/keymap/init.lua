local nnoremap = require("jmatth11.keymap").nnoremap

-- convenient newlines
nnoremap("<leader>o", "o<esc>")
nnoremap("<leader>O", "O<esc>")

-- tab mappings
nnoremap("<leader>tr", ":tabr<cr>")
nnoremap("<leader>tl", ":tabl<cr>")
nnoremap("<leader>tp", ":tabp<cr>")
nnoremap("<leader>tn", ":tabn<cr>")

-- git mappings
nnoremap("<leader>gc", ":GBranches<CR>")
nnoremap("<leader>ga", ":Git fetch --all<CR>")
nnoremap("<leader>gb", ":Git blame<cr>")
-- git gutter mappings
nnoremap("<leader>gp", ":GitGutterPreviewHunk<cr>")

-- undo tree mappings
nnoremap("<leader>u", ":UndotreeToggle<CR>")

nnoremap("<leader><C-n>", ":NERDTree<CR>")

-- Disable Arrow keys in Escape mode
nnoremap("<up>", "<nop>")
nnoremap("<down>", "<nop>")
nnoremap("<left>", "<nop>")
nnoremap("<right>", "<nop>")
