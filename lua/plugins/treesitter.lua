return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, {
				"bash",
				"go",
				"gomod",
				"gosum",
				"gowork",
				"html",
				"css",
				"javascript",
				"typescript",
				"tsx",
				"json",
				"yaml",
				"sql",
			})
		end,
	},
}
