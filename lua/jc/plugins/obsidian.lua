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
	},
}
