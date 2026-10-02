return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		--priority = 1000,
		-- Pin: latest main needs 'pumborder' (newer nvim 0.12 than v0.12.0-dev-141)
		commit = "605b4603797de970e9f3a4238c199c850da03186", -- v2.0.0 / stable
		opts = {
			flavour = "mocha",
		},
	},
	{
		"scottmckendry/cyberdream.nvim",
		name = "cyberdream",
		lazy = false,
		priority = 1000,
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "cyberdream",
		},
	},
}
