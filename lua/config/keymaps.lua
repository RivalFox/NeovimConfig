-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Note: Ctrl+h/j/k/l navigation is handled by vim-tmux-navigator plugin
-- These keymaps were removed to allow navigation from nvim to tmux panes
-- If you need window-only navigation within nvim, use <C-w>h/j/k/l instead

vim.keymap.set({ "n", "x" }, "<leader>oa", function()
	require("opencode").ask("@this: ")
end, { desc = "Ask OpenCode..." })

vim.keymap.set({ "n", "x" }, "<leader>os", function()
	require("opencode").select()
end, { desc = "Select OpenCode..." })

vim.keymap.set({ "n", "x" }, "go", function()
	return require("opencode").operator("@this ")
end, { desc = "Append range to OpenCode", expr = true })

vim.keymap.set("n", "goo", function()
	return require("opencode").operator("@this ") .. "_"
end, { desc = "Append line to OpenCode", expr = true })

vim.keymap.set("n", "<S-C-u>", function()
	require("opencode").command("session.half.page.up")
end, { desc = "Scroll OpenCode up" })

vim.keymap.set("n", "<S-C-d>", function()
	require("opencode").command("session.half.page.down")
end, { desc = "Scroll OpenCode down" })
