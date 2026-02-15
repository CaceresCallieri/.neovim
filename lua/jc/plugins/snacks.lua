return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		picker = {},
		gh = {},
		dashboard = {
			formats = {
				label = { "%s", hl = "key" },
			},
			preset = {
				header = "\n\n\nWelcome back, sir.\n\n\n\n",
				keys = {
					{ icon = " ", key = "n", label = "n / N", desc = "New Claude", action = ":AgentsSpawn fresh" },
					{ key = "N", action = ":AgentsSpawn! fresh", hidden = true },
					{ icon = " ", key = "c", label = "c / C", desc = "Continue Claude", action = ":AgentsSpawn continue" },
					{ key = "C", action = ":AgentsSpawn! continue", hidden = true },
					{ icon = " ", key = "r", label = "r / R", desc = "Resume Claude", action = ":AgentsSpawn resume" },
					{ key = "R", action = ":AgentsSpawn! resume", hidden = true },
					{ icon = " ", key = "e", desc = "File Explorer", action = ":Neotree toggle" },
					{
						icon = " ",
						key = "f",
						desc = "Find Files",
						action = function()
							require("fff").find_files()
						end,
					},
					{ icon = " ", key = "s", desc = "Restore Session", action = ":SessionRestore" },
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = { 10, 0 } },
			},
		},
	},
	keys = {
		-- GitHub Integration (requires gh CLI)
		{ "<leader>Gi", function() Snacks.picker.gh_issue() end, desc = "GitHub Issues" },
		{ "<leader>Gp", function() Snacks.picker.gh_pr() end, desc = "GitHub PRs" },
		{ "<leader>Gm", function() Snacks.picker.gh_issue({ args = { "--author", "@me" } }) end, desc = "My GitHub Issues" },
		{ "<leader>GM", function() Snacks.picker.gh_pr({ args = { "--author", "@me" } }) end, desc = "My GitHub PRs" },
	},
}
