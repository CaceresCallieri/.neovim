return {
	dir = "~/Dev/orchestrator.nvim",
	name = "orchestrator.nvim",
	dev = true,
	event = "VeryLazy", -- Load lazily, spawning handles instance creation
	config = function()
		require("orchestrator").setup()
	end,
	keys = {
		-- Prompt editor
		{ "<leader>ap", "<cmd>PromptEditorToggle<cr>", desc = "Toggle prompt editor" },
		{ "<C-S-Space>", "<cmd>PromptEditorToggle<cr>", mode = { "n", "i", "t" }, desc = "Toggle prompt editor" },
		{ "<C-S-CR>", "<cmd>PromptEditorSend<cr>", mode = { "n", "i" }, desc = "Send prompt to Claude" },

		-- Agent management
		{ "<leader>aa", "<cmd>AgentsPick<cr>", desc = "AI/Agents picker" },
		{ "<leader>an", "<cmd>AgentsSpawn fresh<cr>", desc = "New Claude" },
		{ "<leader>ar", "<cmd>AgentsSpawn resume<cr>", desc = "Resume Claude" },
		{ "<leader>ac", "<cmd>AgentsSpawn continue<cr>", desc = "Continue Claude" },
	},
}
