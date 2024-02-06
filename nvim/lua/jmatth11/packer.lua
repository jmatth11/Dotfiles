
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require("packer").startup(function(use)
    -- packer itself
    use("wbthomason/packer.nvim")

    -- LSP essentials
    use("neovim/nvim-lspconfig")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/nvim-cmp")
    -- LSP essentials +
    use({"tzachar/cmp-tabnine", run = "./install.sh" })
    use("onsails/lspkind-nvim")
    use("nvim-lua/lsp_extensions.nvim")
    use("glepnir/lspsaga.nvim")
    use("simrat39/symbols-outline.nvim")
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")

    -- Nice file markers
    use("ThePrimeagen/harpoon")

    -- Nice git wrapper functions
    use("tpope/vim-fugitive")
    use("airblade/vim-gitgutter")

    -- visualize undo tree
    use("mbbill/undotree")

    -- telescope and pre-reqs
    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")
    use("nvim-telescope/telescope.nvim")
    -- FZF native plugin for telescope
    use({"nvim-telescope/telescope-fzf-native.nvim",
        run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
    })
    -- ripgrep commands
    use("BurntSushi/ripgrep")
    -- tree-sitter (abstract syntax tree)
    use({"nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function()
            local tsconfig = require("nvim-treesitter.configs")
            tsconfig.setup(require("jmatth11.treesitter"))
        end
    })

    -- color themes
    use("gruvbox-community/gruvbox")
    use({"catppuccin/nvim", as = "catppuccin"})
    use("folke/tokyonight.nvim")

    -- interact with tree sitter
    use("nvim-treesitter/playground")
    use("romgrk/nvim-treesitter-context")

    -- debugging protocol
    use("mfussenegger/nvim-dap")
    use("rcarriga/nvim-dap-ui")
    use("theHamsta/nvim-dap-virtual-text")
    use("mxsdev/nvim-dap-vscode-js")
    use({
        "microsoft/vscode-js-debug",
        opt = true,
        run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
    })

    -- local plugins
    use("/media/jmatth93/ExtraDrive1/git/lua/notey.nvim")

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
