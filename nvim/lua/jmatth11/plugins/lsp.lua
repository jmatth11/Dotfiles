local nnoremap = require("jmatth11.keymap").nnoremap
local inoremap = require("jmatth11.keymap").inoremap

return {
  {
    -- LSP configuration for Neovim
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            -- Load luvit types when the `vim.uv` word is found
            { path = "luvit-meta/library",      words = { "vim%.uv" } },
            { path = "/usr/share/awesome/lib/", words = { "awesome" } },
          },
        },
      },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "j-hui/fidget.nvim",                           opts = {} },
      { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
      "stevearc/conform.nvim",
      "b0o/SchemaStore.nvim",
    },
    config = function()
      local extend = function(name, key, values)
        local mod = require(string.format("lspconfig.configs.%s", name))
        local default = mod.default_config
        local keys = vim.split(key, ".", { plain = true })
        while #keys > 0 do
          local item = table.remove(keys, 1)
          default = default[item]
        end

        if vim.islist(default) then
          for _, value in ipairs(default) do
            table.insert(values, value)
          end
        else
          for item, value in pairs(default) do
            if not vim.tbl_contains(values, item) then
              values[item] = value
            end
          end
        end
        return values
      end

      local capabilities = nil
      if pcall(require, "cmp_nvim_lsp") then
        capabilities = require("cmp_nvim_lsp").default_capabilities()
      end

      local lspconfig = require "lspconfig"

      -- packages from this list https://github.com/mason-org/mason-registry/blob/main/packages/astro-language-server/package.yaml
      local servers = {
        -- bash
        bashls = true,
        -- Go
        gopls = {
          manual_install = true,
          settings = {
            gopls = {
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
            },
          },
        },
        --delve = {
        --  filetypes = { "go" },
        --  root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
        --},
        -- Zig
        zls = {
          manual_install = true,
          filetypes = { "zig" },
          root_dir = lspconfig.util.root_pattern("build.zig", "build.zig.lock", "zig.mod", ".git"),
        },
        -- Lua
        lua_ls = true,
        -- Templating languages
        templ = true,
        -- TOML files
        taplo = true,
        -- Python
        basedpyright = {
          manual_install = true,
          filetypes = { "python" },
          root_dir = lspconfig.util.root_pattern("pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git"),
        },
        -- Python linter/code formatter
        ruff = { manual_install = true },
        --debugpy = {
        --  manual_install = true,
        --  filetypes = { "python" },
        --  cmd = { "debugpy" },
        --  root_dir = lspconfig.util.root_pattern("pyproject.toml", ".git"),
        --},
        -- JS/TS stuff
        biome = true,
        -- ts_ls = {
        --   root_dir = require("lspconfig").util.root_pattern "package.json",
        --   single_file = false,
        --   server_capabilities = {
        --     documentFormattingProvider = false,
        --   },
        -- },
        -- VS Code TypeScript Language Server
        vtsls = {
          server_capabilities = {
            documentFormattingProvider = false,
          },
        },
        --prettier = {
        --  manual_install = true,
        --  filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "json", "css", "scss", "less" },
        --},
        -- JSON
        jsonls = {
          server_capabilities = {
            documentFormattingProvider = false,
          },
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },
        -- CSS
        cssls = {
          server_capabilities = {
            documentFormattingProvider = false,
          },
        },
        -- YAML
        yamlls = {
          settings = {
            yaml = {
              schemaStore = {
                enable = false,
                url = "",
              },
              -- schemas = require("schemastore").yaml.schemas(),
            },
          },
        },
        -- C/C++
        clangd = {
          -- cmd = { "clangd", unpack(require("custom.clangd").flags) },
          -- TODO: Could include cmd, but not sure those were all relevant flags.
          --    looks like something i would have added while i was floundering
          init_options = { clangdFileStatus = true },

          filetypes = { "c", "h", "cpp", "hpp"},
        },

        -- Tailwind CSS
        tailwindcss = {
          init_options = {
            userLanguages = {
              elixir = "phoenix-heex",
              eruby = "erb",
              heex = "phoenix-heex",
            },
          },
          filetypes = extend("tailwindcss", "filetypes", { "ocaml.mlx" }),
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  [[class: "([^"]*)]],
                  [[className="([^"]*)]],
                },
              },
              includeLanguages = extend("tailwindcss", "settings.tailwindCSS.includeLanguages", {
                ["ocaml.mlx"] = "html",
              }),
            },
          },
        },
        -- SQL language server
        sqlls = true,
        -- Terraform
        terraformls = {
          filetypes = { "terraform", "tf" },
          root_dir = lspconfig.util.root_pattern("*.tf", ".git"),
        },
      }

      local servers_to_install = vim.tbl_filter(function(key)
        local t = servers[key]
        if type(t) == "table" then
          return not t.manual_install
        else
          return t
        end
      end, vim.tbl_keys(servers))

      require("mason").setup()

      local ensure_installed = {}
      vim.list_extend(ensure_installed, servers_to_install)
      require("mason-tool-installer").setup { ensure_installed = ensure_installed }

      for name, config in pairs(servers) do
        if config == true then
          config = {}
        end
        config = vim.tbl_deep_extend("force", {}, {
          capabilities = capabilities,
        }, config)

        lspconfig[name].setup(config)
      end

      local test_callbacks = {
        ts_ls = {
          test_file = function()
            local filename = vim.api.nvim_buf_get_name(0)
            vim.cmd("vsplit | term npx jest " .. filename)
          end,
          test_all = function()
            vim.cmd("vsplit | term npx jest")
          end,
        },
        vtsls = {
          test_file = function()
            local filename = vim.api.nvim_buf_get_name(0)
            vim.cmd("vsplit | term npx jest " .. filename)
          end,
          test_all = function()
            vim.cmd("vsplit | term npx jest")
          end,
        },
        basedpyright = {
          test_file = function()
            local filename = vim.api.nvim_buf_get_name(0)
            vim.cmd("vsplit | term python -m pytest " .. filename)
          end,
          test_all = function()
            vim.cmd("vsplit | term python -m pytest")
          end,
        },
      }

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

          local settings = servers[client.name]
          local custom_funcs = test_callbacks[client.name]

          if type(settings) ~= "table" then
            settings = {}
          end

          local builtin = require "telescope.builtin"

          vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
          nnoremap("<leader>gd", function() builtin.lsp_definitions() end)
          nnoremap("<leader>gD", function() vim.lsp.buf.declaration() end)
          nnoremap("<leader>gT", function() vim.lsp.buf.type_definition() end)
          nnoremap("<leader>gr", function() builtin.lsp_references() end)
          nnoremap("<leader>gi", function() vim.lsp.buf.implementation() end)
          nnoremap("<leader>K", function() vim.lsp.buf.hover() end)
          nnoremap("<leader>Kf", function() vim.diagnostic.open_float() end)
          nnoremap("<leader>ws", function() vim.lsp.buf.workspace_symbol() end)
          nnoremap("<leader>wd", function() builtin.lsp_document_symbols() end)
          nnoremap("<leader>ca", function() vim.lsp.buf.code_action() end)
          nnoremap("<leader>rn", function() vim.lsp.buf.rename() end)
          nnoremap("<leader><C-f>", function() vim.lsp.buf.format({ async = true }) end)
          nnoremap("[d", function() vim.diagnostic.get_next() end)
          nnoremap("]d", function() vim.diagnostic.get_prev() end)
          inoremap("<leader>Ks", function() vim.lsp.buf.signature_help() end)
          if custom_funcs ~= nil then
            if custom_funcs["test_file"] ~= nil then
              nnoremap("<leader>tf", custom_funcs["test_file"])
            end
            if custom_funcs["test_all"] ~= nil then
              nnoremap("<leader>tF", custom_funcs["test_all"])
            end
          end

          local filetype = vim.bo[bufnr].filetype

          -- Override server capabilities
          if settings.server_capabilities then
            for k, v in pairs(settings.server_capabilities) do
              if v == vim.NIL then
                ---@diagnostic disable-next-line: cast-local-type
                v = nil
              end

              client.server_capabilities[k] = v
            end
          end
        end,
      })

      require("lsp_lines").setup()
      vim.diagnostic.config { virtual_text = true, virtual_lines = false }

      vim.keymap.set("", "<leader>l", function()
        local config = vim.diagnostic.config() or {}
        if config.virtual_text then
          vim.diagnostic.config { virtual_text = false, virtual_lines = true }
        else
          vim.diagnostic.config { virtual_text = true, virtual_lines = false }
        end
      end, { desc = "Toggle lsp_lines" })

      local opts = {
        -- whether to highlight the currently hovered symbol
        -- disable if your cpu usage is higher than you want it
        -- or you just hate the highlight
        -- default: true
        highlight_hovered_item = true,

        -- whether to show outline guides
        -- default: true
        show_guides = true,
      }

      require("symbols-outline").setup(opts)
    end,
  },
  {
    -- Autocompletion plugin for Neovim
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "onsails/lspkind-nvim",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "nvim-neotest/nvim-nio",
      "simrat39/symbols-outline.nvim",
    },
    config = function()
      local lsp_caps = vim.lsp.protocol.make_client_capabilities()
      lsp_caps.textDocument.completion.completionItem.snippetSupport = true
      -- Setup nvim-cmp.
      local cmp = require("cmp")
      local source_mapping = {
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        cmp_tabnine = "[TN]",
        path = "[Path]",
      }
      local lspkind = require("lspkind")

      cmp.setup({
        snippet = {
          expand = function(args)
            -- For `luasnip` user.
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),

        formatting = {
          format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            local menu = source_mapping[entry.source.name]
            -- if using tabnine
            if entry.source.name == "cmp_tabnine" then
              if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                menu = entry.completion_item.data.detail .. " " .. menu
              end
              vim_item.kind = ""
            end
            vim_item.menu = menu
            return vim_item
          end,
        },

        sources = {
          { name = "nvim_lsp" },

          { name = "luasnip" },

          { name = "buffer" },
        },
      })
    end,
  }
}
