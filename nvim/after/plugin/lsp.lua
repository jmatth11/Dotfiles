local Remap = require("jmatth11.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

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
			-- For `vsnip` user.
			-- vim.fn["vsnip#anonymous"](args.body)

			-- For `luasnip` user.
			require("luasnip").lsp_expand(args.body)

			-- For `ultisnips` user.
			-- vim.fn["UltiSnips#Anon"](args.body)
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
		-- tabnine completion? yayaya

		{ name = "cmp_tabnine" },

		{ name = "nvim_lsp" },

		-- For vsnip user.
		-- { name = 'vsnip' },

		-- For luasnip user.
		{ name = "luasnip" },

		-- For ultisnips user.
		-- { name = 'ultisnips' },

		{ name = "buffer" },
	},
})

local tabnine = require("cmp_tabnine.config")
tabnine:setup({
	max_lines = 1000,
	max_num_results = 20,
	sort = true,
	run_on_every_keystroke = true,
	snippet_placeholder = "..",
})

local function config(_config, custom_funcs)
	return vim.tbl_deep_extend("force", {
		capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
		on_attach = function()
			nnoremap("<leader>gd", function() vim.lsp.buf.definition() end)
			nnoremap("<leader>gD", function() vim.lsp.buf.declaration() end)
			nnoremap("<leader>gr", function() vim.lsp.buf.references() end)
			nnoremap("<leader>gi", function() vim.lsp.buf.implementation() end)
			nnoremap("<leader>K", function() vim.lsp.buf.hover() end)
			nnoremap("<leader>Kf", function() vim.diagnostic.open_float() end)
			nnoremap("<leader>ws", function() vim.lsp.buf.workspace_symbol() end)
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
		end,
	}, _config or {})
end

require("lspconfig").ts_ls.setup(config(nil, {
    test_all = function()
        vim.cmd("vsplit | term npx jest")
    end,
    test_file = function()
        local filename = vim.api.nvim_buf_get_name(0)
        vim.cmd("vsplit | term npx jest " .. filename)
    end,
}))
require("lspconfig").csharp_ls.setup(config())
require("lspconfig").clangd.setup(config())
require("lspconfig").eslint.setup(config())
-- require("lspconfig").angularls.setup(config())
require("lspconfig").cssls.setup(config())
require("lspconfig").zls.setup(config({}))
require'lspconfig'.basedpyright.setup(config({}))
require("lspconfig").gopls.setup(config({
	cmd = { "gopls", "serve" },
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
}))
require('lspconfig').lua_ls.setup(config({
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}))

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

local snippets_paths = function()
	local plugins = { "friendly-snippets" }
	local paths = {}
	local path
	local root_path = vim.env.HOME .. "/.vim/plugged/"
	for _, plug in ipairs(plugins) do
		path = root_path .. plug
		if vim.fn.isdirectory(path) ~= 0 then
			table.insert(paths, path)
		end
	end
	return paths
end
