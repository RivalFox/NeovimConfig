-- Workaround: nvim-lspconfig sets root_markers to a nested table (e.g. { { 'a', 'b' }, { '.git' } })
-- when Neovim >= 0.11.3, but vim.fs.root() expects a flat list of strings. Passing a nested table
-- causes "invalid value (table) at index 2 in table for 'concat'" in vim.fs.joinpath.

local function flatten_markers(markers)
	if type(markers) ~= "table" then
		return markers
	end
	local result = {}
	for _, m in ipairs(markers) do
		if type(m) == "string" then
			result[#result + 1] = m
		elseif type(m) == "table" then
			for _, s in ipairs(flatten_markers(m)) do
				result[#result + 1] = s
			end
		end
	end
	return result
end

do
	local v = vim.version and vim.version() or { major = 0, minor = 0, patch = 0 }
	-- 0.11.3+ introduced vim.lsp passing root_markers into vim.fs.root(); 0.12+ still does.
	-- The old gate (minor == 11 only) skipped newer releases and left nested markers from lspconfig broken.
	local needs_workaround = v.major == 0 and (v.minor > 11 or (v.minor == 11 and v.patch >= 3))
	if needs_workaround and not vim.g.__lazyvim_root_markers_flatten_workaround then
		vim.g.__lazyvim_root_markers_flatten_workaround = true
		local original_start = vim.lsp.start
		---@diagnostic disable-next-line: duplicate-set-field
		function vim.lsp.start(config, opts)
			opts = opts or {}
			if opts._root_markers and type(opts._root_markers) == "table" then
				opts = vim.deepcopy(opts)
				opts._root_markers = flatten_markers(opts._root_markers)
			end
			return original_start(config, opts)
		end
	end
end

return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			inlay_hints = { enabled = false },
			servers = {
				templ = {},
				sqls = {},
			},
		},
	},
}
