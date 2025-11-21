return {
  {
    "RRethy/base16-nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "base16-brewer"
    end,
  },
  -- good colorschemes
  {
    "Shatur/neovim-ayu",
    lazy = true,
  },
  {
    "miikanissi/modus-themes.nvim",
    lazy = true,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
  },
  {
    "gremble0/yellowbeans.nvim",
    lazy = true,
  },
  {
    "rockyzhang24/arctic.nvim",
    lazy = true,
  },
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = true,
  },
  {
    "uloco/bluloco.nvim",
    lazy = true,
  },
  {
    "kepano/flexoki-neovim",
    lazy = true,
  },
  {
    "vim-scripts/MountainDew.vim",
    lazy = true,
  },
  {
    "maxmx03/fluoromachine.nvim",
    lazy = true,
  },

  -- okay colorschemes
  { "rose-pine/neovim", name = "rose-pine", lazy = true },
  {
    "jesseleite/nvim-noirbuddy",
    lazy = true,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
  },
  { "catppuccin/nvim", name = "catppuccin", lazy = true },
}
