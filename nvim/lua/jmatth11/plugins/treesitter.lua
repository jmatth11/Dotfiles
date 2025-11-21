return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/playground",
      "nvim-treesitter/nvim-treesitter-refactor",
      "nvim-treesitter/nvim-treesitter-context",
    },
    event = "BufEnter *",
    lazy = true,
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "gdscript",
        "godot_resource",
        "gdshader",
        "c",
        "zig",
        "bash",
        "lua",
        "markdown",
        "json",
        "html",
      },
      auto_install = true,
      ignore_install = { "php", "phpdoc" },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
      },
      indent = {
        enable = true,
      },
    },
  }
}
