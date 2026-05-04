return {
	"rmagatti/auto-session",
	config = function()
		-- NOTE: `terminal` is intentionally excluded from sessionoptions.
		-- orchestrator.nvim owns the lifecycle of Claude terminals: it serializes
		-- live agents on SessionSavePre and respawns them via `claude --resume <id>`
		-- on SessionRestorePost. If `terminal` were included, Vim would resurrect
		-- dead terminal buffers (no underlying process), colliding with orchestrator's
		-- restore and leaving the user with empty zombie panes.
		vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,localoptions"

		local auto_session = require("auto-session")
		auto_session.setup({
			auto_restore = false, -- Restore is dashboard-driven (snacks `s` key → :SessionRestore)
			suppressed_dirs = { "~/", "~/projects/", "~/Downloads", "~/Documents", "~/Desktop/" },
			-- Persist orchestrator.nvim Claude instances alongside the Vim session.
			-- auto-session calls these callbacks (it does NOT emit User autocmds for
			-- save/restore, so config-driven hooks are the only integration point).
			post_save_cmds = {
				function()
					local ok, orch = pcall(require, "orchestrator")
					if ok and orch.session_save then
						orch.session_save()
					end
				end,
			},
			post_restore_cmds = {
				function()
					local ok, orch = pcall(require, "orchestrator")
					if ok and orch.session_restore then
						orch.session_restore()
					end
				end,
			},
		})

		local keymap = vim.keymap
		keymap.set("n", "<leader>S", "", { desc = "Session managing" })
		keymap.set("n", "<leader>Sr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
		keymap.set("n", "<leader>Ss", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" })
	end,
}
