return {
	"rmagatti/auto-session",
	config = function()
		local auto_session = require("auto-session")

		auto_session.setup({
			auto_restore_enabled = false,
			auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
		})

		local keymap = vim.keymap

		keymap.set("n", "<leader>S", "", { desc = "Session managing" })
		keymap.set("n", "<leader>Sr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
		keymap.set("n", "<leader>Ss", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" })
	end,
}
