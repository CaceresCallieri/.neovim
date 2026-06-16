return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		picker = {},
		gh = {},
		-- Dashboard integration: welcome screen shown on startup (nvim or nvim .)
		-- Related: options.lua (arglist clearing), neo-tree.lua (hijack disabled), orchestrator.lua (cmd stubs)
		dashboard = {
			formats = {
				label = { "%s", hl = "key" },
			},
			preset = {
				header = "\n\n\nWelcome back, sir.\n\n\n\n",
				keys = {
					{ icon = " ", key = "n", desc = "New Claude", action = ":AgentsSpawn! fresh" },
					{ icon = " ", key = "c", desc = "Continue Claude", action = ":AgentsSpawn! continue" },
					{ icon = " ", key = "r", desc = "Resume Claude", action = ":AgentsSpawn! resume" },
						{ icon = " ", key = "y", desc = "Yazi", action = ":Yazi cwd" },
					{ icon = " ", key = "e", desc = "File Explorer", action = ":Neotree toggle" },
					{
						icon = " ",
						key = "f",
						desc = "Find Files",
						action = function()
							local ok, fff = pcall(require, "fff")
							if ok then
								fff.find_files()
							else
								vim.notify("fff.nvim not available", vim.log.levels.WARN)
							end
						end,
					},
					{ icon = " ", key = "s", desc = "Restore Session", action = ":AutoSession restore" },
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = { 10, 0 } },
				-- Saved-session preview: lists the Claude agents that would be
				-- respawned if the user presses `s` (Restore Session). Reads the
				-- orchestrator manifest at dashboard render time and resolves
				-- each agent's title from its .jsonl `custom-title` record.
				--
				-- Pattern: the WHOLE section is a function (not `text = function`).
				-- snacks's resolve() pre-evaluates a function-typed section and
				-- recurses on the result, while a function placed in `text` is
				-- passed straight to dashboard:texts() which crashes trying to
				-- index it (snacks/dashboard.lua:372). Returning nil here skips
				-- the section entirely — fresh cwds see no preview block.
				function()
					local ok, session = pcall(require, "orchestrator.session")
					if not ok then
						return nil
					end
					local preview = session.preview(vim.fn.getcwd())
					if preview.count == 0 then
						return nil
					end
					local lines = {
						string.format("Saved Claude agents (%d):", preview.count),
					}
					for i, item in ipairs(preview.items) do
						table.insert(lines, string.format("  %d. %s", i, item.title or "(unnamed)"))
					end
					return {
						text = table.concat(lines, "\n"),
						padding = 1,
					}
				end,
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
