return {
	dir = "~/Dev/prompt-editor.nvim",
	name = "prompt-editor.nvim",
	dev = true,
	keys = {
		{ "<leader>ap", "<cmd>PromptToggle<cr>", desc = "Toggle prompt editor" },
		{ "<C-S-Space>", "<cmd>PromptToggle<cr>", mode = { "n", "i", "t" }, desc = "Toggle prompt editor" },
	},
}
