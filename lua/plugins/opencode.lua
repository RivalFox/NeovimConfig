return {
	"nickjvandyke/opencode.nvim",
	--version = "*",
	config = function()
		--@type opencode.Opts
		vim.g.opencode_opts = {
			-- configuration, if any; goto definition on the type or field for details
		}

		vim.o.autoread = true
	end,
}
