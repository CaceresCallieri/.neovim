return {
	"rmagatti/auto-session",
	config = function()
		-- NOTE: `terminal` is intentionally excluded from sessionoptions.
		-- orchestrator.nvim owns the lifecycle of Claude terminals: it serializes
		-- live agents from auto-session's post_save_cmds hook and respawns them
		-- via `claude --resume <id>` from post_restore_cmds (see callbacks below).
		-- If `terminal` were included, Vim would resurrect dead terminal buffers
		-- (no underlying process), colliding with orchestrator's restore and
		-- leaving the user with empty zombie panes.
		vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,localoptions"

		local auto_session = require("auto-session")
		auto_session.setup({
			auto_restore = false, -- Restore is dashboard-driven (snacks `s` key → :SessionRestore)
			suppressed_dirs = { "~/", "~/projects/", "~/Downloads", "~/Documents", "~/Desktop/" },
			-- Persist orchestrator.nvim Claude instances alongside the Vim session.
			-- auto-session calls these callbacks (it does NOT emit User autocmds for
			-- save/restore, so config-driven hooks are the only integration point).
			--
			-- neo-tree integration: close the sidebar before save so the session
			-- file doesn't capture a broken neo-tree window reference (the buffer
			-- name persists but its tree state doesn't), then reopen it after
			-- restore. Without this, :SessionRestore brings back a window slot
			-- with no sidebar contents — the user's reported "no file tree on
			-- restore" bug.
			pre_save_cmds = {
				function()
					pcall(vim.cmd, "Neotree close")
				end,
			},
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
				function()
					-- Defer so the restore-driven window layout settles before
					-- neo-tree carves out its slot — opening synchronously here
					-- can race with edgy's slot allocation.
					vim.schedule(function()
						pcall(vim.cmd, "Neotree show filesystem")
					end)
				end,
			},
		})

		local keymap = vim.keymap
		keymap.set("n", "<leader>S", "", { desc = "Session managing" })
		keymap.set("n", "<leader>Sr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
		keymap.set("n", "<leader>Ss", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" })
	end,
}
