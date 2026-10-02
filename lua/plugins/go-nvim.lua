return {
	{
		"ray-x/go.nvim",
		dependencies = {
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		ft = { "go", "gomod", "gowork", "gotmpl" },
		event = { "CmdlineEnter" },
		build = ':lua require("go.install").update_all_sync()',
		opts = {
			-- AI / MCP disabled
			ai = { enable = false },
			mcp = { enable = false },

			-- LSP (go.nvim owns gopls)
			lsp_cfg = true,
			lsp_gofumpt = true,
			lsp_keymaps = false, -- keep LazyVim LSP maps
			lsp_codelens = false,
			lsp_inlay_hints = { enable = false },
			lsp_document_formatting = true,
			lsp_impl = { enable = true },

			-- Format
			goimports = "gopls",
			gofmt = "gofumpt",
			fillstruct = "gopls",

			-- Don't override LazyVim diagnostic UI
			diagnostic = false,

			-- DAP
			dap_debug = true,
			dap_debug_gui = {},
			dap_debug_vt = { enabled = true, enabled_commands = true, all_frames = true },
			dap_debug_keymap = true,

			-- Tests / UX
			test_runner = "go",
			run_in_floaterm = true,
			textobjects = true,
			luasnip = true,

			verbose = false,
		},
		config = function(_, opts)
			require("go").setup(opts)

			local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.go",
				callback = function()
					require("go.format").goimports()
				end,
				group = format_sync_grp,
			})
		end,
	},
}
