return {
	{
		"stevearc/conform.nvim",
		opts = function(_, opts)
			opts.formatters_by_ft = opts.formatters_by_ft or {}

			-- Templ
			opts.formatters_by_ft.templ = { "templ" }

			-- Web
			opts.formatters_by_ft.html = { "prettier" }
			opts.formatters_by_ft.css = { "prettier" }
			opts.formatters_by_ft.scss = { "prettier" }
			opts.formatters_by_ft.less = { "prettier" }
			opts.formatters_by_ft.javascript = { "prettier" }
			opts.formatters_by_ft.javascriptreact = { "prettier" }
			opts.formatters_by_ft.typescript = { "prettier" }
			opts.formatters_by_ft.typescriptreact = { "prettier" }
			opts.formatters_by_ft.json = { "prettier" }
			opts.formatters_by_ft.jsonc = { "prettier" }
			opts.formatters_by_ft.yaml = { "prettier" }
			opts.formatters_by_ft.markdown = { "prettier" }

			-- SQL (Postgres): prefer a dedicated SQL formatter if you install one.
			-- Conform supports several; leaving this as a safe default that won't error if missing.
			opts.formatters_by_ft.sql = opts.formatters_by_ft.sql or {}
		end,
	},
}
