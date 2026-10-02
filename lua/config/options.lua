-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.lazyvim_cmp = "nvim-cmp"

-- Some nvim-0.12-dev builds advertise nvim-0.12 before `vim.text.diff` exists. conform.nvim then
-- calls `vim.text.diff` and crashes. Delegate to `vim.diff` until the runtime provides the real API.
if vim.fn.has("nvim-0.12") == 1 and vim.text and not vim.text.diff and type(vim.diff) == "function" then
	vim.text.diff = vim.diff
end

vim.g.snacks_animate = false
