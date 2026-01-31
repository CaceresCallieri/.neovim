return {
	dir = "~/Dev/orchestrator.nvim",
	name = "orchestrator.nvim",
	dev = true,
	event = "VeryLazy", -- Load lazily, spawning handles instance creation
	config = function()
		require("orchestrator").setup()
	end,
	keys = {
		-- Prompt editor (global keymaps - buffer-local keymaps handled by plugin defaults)
		{ "<leader>ap", "<cmd>PromptEditorToggle<cr>", desc = "Toggle prompt editor" },
		{ "<C-S-Space>", "<cmd>PromptEditorToggle<cr>", mode = { "n", "i", "t" }, desc = "Toggle prompt editor" },
		{ "<C-S-CR>", "<cmd>PromptEditorSend<cr>", mode = { "n", "i" }, desc = "Send prompt to Claude" },
		-- NOTE: Tab navigation keymaps (<C-Tab>, <C-S-n>, <C-S-x>) are now buffer-local
		-- and configured via setup(opts).keymaps.prompt_editor

		-- Agent management
		{ "<leader>aa", "<cmd>AgentsPick<cr>", desc = "AI/Agents picker" },
		{ "<leader>an", "<cmd>AgentsSpawn fresh<cr>", desc = "New Claude" },
		{ "<leader>ar", "<cmd>AgentsSpawn resume<cr>", desc = "Resume Claude" },
		{ "<leader>ac", "<cmd>AgentsSpawn continue<cr>", desc = "Continue Claude" },

		-- Agent management (⚠ DANGEROUS - runs with --dangerously-skip-permissions)
		{ "<leader>aN", "<cmd>AgentsSpawn! fresh<cr>", desc = "⚠ New Claude (skip permissions)" },
		{ "<leader>aR", "<cmd>AgentsSpawn! resume<cr>", desc = "⚠ Resume Claude (skip permissions)" },
		{ "<leader>aC", "<cmd>AgentsSpawn! continue<cr>", desc = "⚠ Continue Claude (skip permissions)" },

		-- Agent navigation
		{ "<C-1>", "<cmd>AgentsFocus 1<cr>", mode = { "n", "t" }, desc = "Focus Claude 1" },
		{ "<C-2>", "<cmd>AgentsFocus 2<cr>", mode = { "n", "t" }, desc = "Focus Claude 2" },
		{ "<C-3>", "<cmd>AgentsFocus 3<cr>", mode = { "n", "t" }, desc = "Focus Claude 3" },
		{ "<C-4>", "<cmd>AgentsFocus 4<cr>", mode = { "n", "t" }, desc = "Focus Claude 4" },
		{ "<C-5>", "<cmd>AgentsFocus 5<cr>", mode = { "n", "t" }, desc = "Focus Claude 5" },

		-- Agent close
		{ "<C-S-q>", "<cmd>AgentsClose<cr>", mode = { "n", "t" }, desc = "Close Claude instance" },

		-- Edit tracker
		{ "<leader>ae", "<cmd>AgentsEdits<cr>", desc = "Show Claude edits (quickfix)" },
		{ "<leader>aj", "<cmd>AgentsJump<cr>", desc = "Jump to last edit" },
	},
}
