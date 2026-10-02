return {
	-- Dadbod completion for SQL buffers (works nicely with nvim-cmp).
	{
		"kristijanhusak/vim-dadbod-completion",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
		},
		ft = { "sql", "mysql", "plsql" },
	},

	-- sqls <-> dadbod bridge: enables schema-aware completion/hover using your live DB connections.
	{
		"nanotee/sqls.nvim",
		ft = { "sql", "mysql", "plsql" },
	},

	-- Add cmp source for dadbod completion in SQL buffers.
	{
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			opts.sources = opts.sources or {}
			-- Only used when filetype is SQL via cmp's filetype setup downstream.
			table.insert(opts.sources, { name = "vim-dadbod-completion" })
		end,
	},

	-- Wire sqls.nvim into sqls LSP attach.
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			opts.servers = opts.servers or {}
			opts.servers.sqls = opts.servers.sqls or {}
			local prev_on_attach = opts.servers.sqls.on_attach
			opts.servers.sqls.on_attach = function(client, bufnr)
				if type(prev_on_attach) == "function" then
					pcall(prev_on_attach, client, bufnr)
				end
				pcall(function()
					require("sqls").on_attach(client, bufnr)
				end)
			end
		end,
	},
}
