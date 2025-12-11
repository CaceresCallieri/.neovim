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

		-- Prompt Editor "tabs"
		{ "<C-Tab>", "<cmd>PromptEditorNext<cr>", mode = { "n", "i" }, desc = "Next prompt tab" },
		{ "<C-S-n>", "<cmd>PromptEditorNew<cr>", mode = { "n", "i" }, desc = "New prompt tab" },
		{ "<C-S-x>", "<cmd>PromptEditorDelete<cr>", mode = { "n", "i" }, desc = "Close prompt tab" },

		-- Agent management
		{ "<leader>aa", "<cmd>AgentsPick<cr>", desc = "AI/Agents picker" },
		{ "<leader>an", "<cmd>AgentsSpawn fresh<cr>", desc = "New Claude" },
		{ "<leader>ar", "<cmd>AgentsSpawn resume<cr>", desc = "Resume Claude" },
		{ "<leader>ac", "<cmd>AgentsSpawn continue<cr>", desc = "Continue Claude" },

		-- Agent navigation
		{ "<C-1>", "<cmd>AgentsFocus 1<cr>", mode = { "n", "t" }, desc = "Focus Claude 1" },
		{ "<C-2>", "<cmd>AgentsFocus 2<cr>", mode = { "n", "t" }, desc = "Focus Claude 2" },
		{ "<C-3>", "<cmd>AgentsFocus 3<cr>", mode = { "n", "t" }, desc = "Focus Claude 3" },
		{ "<C-4>", "<cmd>AgentsFocus 4<cr>", mode = { "n", "t" }, desc = "Focus Claude 4" },
		{ "<C-5>", "<cmd>AgentsFocus 5<cr>", mode = { "n", "t" }, desc = "Focus Claude 5" },
	},
}
