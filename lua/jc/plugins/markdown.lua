-- render-markdown.nvim — in-buffer Markdown rendering.
--
-- Decorates Markdown directly inside the buffer using treesitter + extmarks:
-- sized/coloured headings, ● bullets, code-block backgrounds with language
-- icons, aligned tables, rendered checkboxes/callouts. It stays editable —
-- the line under the cursor shows the raw markup ("anti-conceal") while every
-- other line renders, so you never lose the source you're typing.
--
-- Prereqs already satisfied by this config:
--   * `markdown` + `markdown_inline` treesitter parsers (treesitter.lua) — required
--   * nvim-web-devicons (icons.lua) — optional; adds code-block language icons
--
-- conceallevel note: options.lua sets a GLOBAL conceallevel = 1 (for obsidian).
-- render-markdown manages conceallevel PER WINDOW — it raises the window to 3
-- while rendering and restores it when toggled off, so the global value is left
-- untouched. Do not bump the global conceallevel to make this work.
--
-- Obsidian: obsidian.nvim's own UI is disabled (obsidian.lua) so render-markdown
-- is the single in-buffer renderer everywhere, including the FPS-game vault —
-- in-buffer renderers double-decorate if more than one runs on a buffer.
return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = { "markdown" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	-- Listing the keymap here (rather than in `config`) makes it visible to
	-- which-key and lazy-loads the plugin on first press as well as on `ft`.
	-- `buf_toggle` flips rendered <-> raw for the CURRENT buffer only, so the
	-- key affects the file you're looking at without touching other open
	-- buffers; `:RenderMarkdown toggle` does it globally for all buffers.
	keys = {
		{ "<leader>um", "<cmd>RenderMarkdown buf_toggle<cr>", desc = "Toggle Markdown rendering" },
	},
	-- Defaults are well-tuned and theme-aware; start from them and reach into
	-- this table for `heading`, `code`, `bullet`, `checkbox`, etc. to taste.
	-- See `:h render-markdown.config` for every knob.
	opts = {},
}
