return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		picker = {},
		gh = {},
	},
	keys = {
		-- GitHub Integration (requires gh CLI)
		{ "<leader>Gi", function() Snacks.picker.gh_issue() end, desc = "GitHub Issues" },
		{ "<leader>Gp", function() Snacks.picker.gh_pr() end, desc = "GitHub PRs" },
		{ "<leader>Gm", function() Snacks.picker.gh_issue({ args = { "--author", "@me" } }) end, desc = "My GitHub Issues" },
		{ "<leader>GM", function() Snacks.picker.gh_pr({ args = { "--author", "@me" } }) end, desc = "My GitHub PRs" },
	},
}
