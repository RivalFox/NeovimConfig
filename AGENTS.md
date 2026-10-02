# AGENTS.md

Personal Neovim config built on LazyVim and lazy.nvim. It is a local git repo (`master`,
no remote). Don't commit unless the user asks.

## Layout and load order

- `init.lua` only calls `require("config.lazy")`.
- `lua/config/lazy.lua` bootstraps lazy.nvim and imports LazyVim, the extras, and then
  `lua/plugins/*`. Each file in `lua/plugins/` returns lazy.nvim specs that get merged with
  LazyVim's defaults. Prefer `opts = function(_, opts) ... end` so you extend those defaults
  instead of replacing them.
- `lua/config/options.lua` runs before lazy.nvim starts. `keymaps.lua` and `autocmds.lua`
  run on `VeryLazy`. Files in `lua/config/` are plain scripts, not plugin specs, so a
  `return { ... }` spec there does nothing.
- Lua files are indented with tabs. There is no stylua config.

## Gotchas

- LazyVim extras are enabled by `{ import = "lazyvim.plugins.extras..." }` lines in
  `lua/config/lazy.lua`. Don't use `:LazyExtras` or `lazyvim.json` (its `extras` list is
  intentionally empty).
- The picker is snacks.picker. `vim.g.lazyvim_picker` is `auto`, and it picks snacks
  because the `editor.telescope` extra is not imported. Don't re-add that extra: it
  disables snacks.picker, which opencode.nvim's `select()` uses.
- Completion uses nvim-cmp, not blink, because `options.lua` sets
  `vim.g.lazyvim_cmp = "nvim-cmp"`. The real `<Tab>` chain lives in
  `lua/plugins/cmp.lua`: snippet_forward, then confirm, then ai_nes, then ai_accept.
- Supermaven comes from the `ai.supermaven` extra but is turned off in
  `lua/plugins/supermaven.lua` (`enabled = false`). Never give it a custom `config` or
  `setup()`, because that breaks LazyVim's cmp `ai_accept` integration.
- Go support comes from `ray-x/go.nvim` (`lua/plugins/go-nvim.lua`), which owns gopls
  (`lsp_cfg = true`), gofumpt, and goimports-on-save. The LazyVim `lang.go` extra isn't
  imported. Don't add `gopls` to the nvim-lspconfig `servers`, or two clients will start.
- Keep these version workarounds unless you've confirmed the bug is fixed upstream:
  - `options.lua` shims `vim.text.diff = vim.diff` because conform.nvim crashes on some
    nvim 0.12-dev builds.
  - `lua/plugins/lsp.lua` wraps `vim.lsp.start` to flatten the nested `root_markers` that
    nvim-lspconfig produces on nvim >= 0.11.3.
  - `catppuccin` is pinned to a specific commit in `lua/plugins/colorscheme.lua`, because
    newer main needs `pumborder`. The active colorscheme is `cyberdream`.
- The `defaults` block in `lazy.lua` sets `lazy = false` and `version = false`, so custom
  plugins load at startup and track the latest commit. `lazy-lock.json` holds the real
  pins. Don't run `:Lazy update` or `:Lazy sync` unless asked, since they rewrite it.
  To update one plugin: `nvim --headless "+Lazy! update <name>" +qa`.
- SQL support pairs the `sqls` LSP with vim-dadbod through `nanotee/sqls.nvim`, wired via
  `on_attach` in `lua/plugins/sql.lua`. conform has no SQL formatter configured on purpose.
- `<C-h/j/k/l>` belong to vim-tmux-navigator. Use `<C-w>h/j/k/l` for window-only moves.
  The tmux prefix is `<C-Space>`.
- OpenCode integration is `nickjvandyke/opencode.nvim` on `main` (OpenCode v2 API; the
  installed `opencode` CLI is v2). `lua/plugins/opencode.lua` follows the README's lazy.nvim
  setup: empty `vim.g.opencode_opts` and keymaps `<C-a>` (ask), `<C-x>` (select), and
  `go`/`goo` (operator). `<C-a>`/`<C-x>` intentionally replace Vim's number
  increment/decrement. The plugin sets `autoread` itself, so buffers reload on agent edits.
  Don't pin `version = "*"`: stable releases only support OpenCode v1.

## Verifying changes

- Check that the config loads without errors: `nvim --headless "+qa"`. Any error output
  means a spec failed to load.
- Check a keymap: `nvim --headless "+lua print(vim.fn.maparg('<C-a>', 'n', false, true).desc)" +qa`.
- Check the active picker: `nvim --headless "+lua print(LazyVim.pick.picker.name)" +qa`.
- Look at plugin state with `:Lazy` and LSP and tool health with `:checkhealth`
  (`:checkhealth opencode` for the OpenCode plugin).
