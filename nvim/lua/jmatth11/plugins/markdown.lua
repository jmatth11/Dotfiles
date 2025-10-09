return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
    lazy = true,
    event = "BufEnter *.md",
    opts = {},
  }
}
