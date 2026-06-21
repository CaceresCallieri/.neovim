-- render-markdown.nvim — in-buffer Markdown rendering.
--
-- Decorates Markdown directly inside the buffer using treesitter + extmarks:
-- sized/coloured headings, ● bullets, code-block backgrounds with language
-- icons, aligned tables, rendered checkboxes/callouts. It stays editable —
-- the line under the cursor shows the raw markup ("anti-conceal") while every
-- other line renders, so you never lose the source you're typing.
--
-- Prereqs already satisfied by this config:
--   * `markdown` + `markdown_inline` treesitter parsers (treesitter.lua)
--   * nvim-web-devicons (icons.lua) — supplies code-block language icons
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
	-- `:RenderMarkdown toggle` flips rendered <-> raw for ALL buffers; the
	-- per-buffer variant is `:RenderMarkdown buf_toggle` if you prefer that.
	keys = {
		{ "<leader>um", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle Markdown rendering" },
	},
	-- Defaults are well-tuned and theme-aware; start from them and reach into
	-- this table for `heading`, `code`, `bullet`, `checkbox`, etc. to taste.
	-- See `:h render-markdown.config` for every knob.
	opts = {},
}
