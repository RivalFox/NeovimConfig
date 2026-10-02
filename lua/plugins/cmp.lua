-- Override nvim-cmp so <Tab> accepts LSP/word completion (in addition to snippet forward and AI).
return {
	{
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			-- Keep buffer completion (useful for HTML/CSS classnames, ids, repeated tokens, etc.).
			-- If it feels too noisy later, we can reduce its priority instead of removing it entirely.

			-- Add "confirm" action: accept the selected completion when menu is visible.
			LazyVim.cmp.actions.confirm = function()
				local cmp = require("cmp")
				if cmp.core.view:visible() or vim.fn.pumvisible() == 1 then
					LazyVim.create_undo()
					cmp.confirm({ select = true })
					return true
				end
			end

			-- Tab: snippet_forward → confirm (LSP/word) → ai_nes → ai_accept → fallback
			opts.mapping["<tab>"] = function(fallback)
				return LazyVim.cmp.map({ "snippet_forward", "confirm", "ai_nes", "ai_accept" }, fallback)()
			end

			-- Small nudge: don't offer 1-char buffer completions everywhere.
			opts.sources = opts.sources or {}
			for _, source in ipairs(opts.sources) do
				if type(source) == "table" and source.name == "buffer" then
					source.keyword_length = source.keyword_length or 2
				end
			end
		end,
	},
}
