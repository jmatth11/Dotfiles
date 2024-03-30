-- set tab stuff
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smarttab = true
vim.opt.smartindent = true

-- vim's default for backspace limits it's use.
-- set to 2 which allows backspace on: indent, eol, and start
-- vim.opt.backspace = 2

vim.opt.guicursor = ""
vim.opt.errorbells = false
-- turn on numbers
vim.opt.number = true
vim.opt.rnu = true
-- don't wrap text
vim.opt.wrap = false
-- highlight search
vim.opt.hlsearch = true
-- increment search
vim.opt.incsearch = true
-- increment window in split
vim.opt.inccommand = "split"
-- don't use swap files
vim.opt.swapfile = false
-- no backups
vim.opt.backup = false
-- use undofiles instead, set undo directory
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
-- turn on term gui colors
vim.opt.termguicolors = true
-- leave 8 lines of space at top or bottom when scrolling
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

-- default is 4000 ms, this is better
vim.opt.updatetime = 50

-- be able to see the 80 character column
vim.opt.colorcolumn = "80"

-- give more room for error messages
vim.opt.cmdheight = 1

vim.opt.wildmode = "longest,list,full"
vim.opt.wildmenu = true

vim.opt.wildignore = "*.pyc,*_build/*,**/node_modules/*,**/.git/*"

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
