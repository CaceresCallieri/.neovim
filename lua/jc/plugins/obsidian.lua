return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	event = {
		"BufReadPre " .. vim.fn.expand("~") .. "/projects/fps-game/docs/**.md",
		"BufNewFile " .. vim.fn.expand("~") .. "/projects/fps-game/docs/**.md",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "FPS Game",
				path = vim.fn.expand("~/projects/fps-game/docs"),
			},
		},
		-- Disable obsidian's own in-buffer UI: render-markdown.nvim now owns
		-- Markdown decoration everywhere (markdown.lua). Two in-buffer renderers
		-- on the same buffer double-decorate, so the vault defers to it too.
		ui = { enable = false },
	},
}
