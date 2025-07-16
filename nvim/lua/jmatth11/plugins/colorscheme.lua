return {
  {
    "tjdevries/colorbuddy.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "ayu"
    end,
  },
  -- good colorschemes
  "Shatur/neovim-ayu",
  "miikanissi/modus-themes.nvim",
  "rebelot/kanagawa.nvim",
  "gremble0/yellowbeans.nvim",
  "rockyzhang24/arctic.nvim",
  "craftzdog/solarized-osaka.nvim",
  "RRethy/base16-nvim",
  "uloco/bluloco.nvim",
  "kepano/flexoki-neovim",
  "vim-scripts/MountainDew.vim",
  "maxmx03/fluoromachine.nvim",

  -- okay colorschemes
  { "rose-pine/neovim", name = "rose-pine" },
  "jesseleite/nvim-noirbuddy",
  "folke/tokyonight.nvim",
  { "catppuccin/nvim", name = "catppuccin" },
}
