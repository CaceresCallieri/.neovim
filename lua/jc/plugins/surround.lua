return {
	"kylechui/nvim-surround",
	event = { "BufReadPre", "BufNewFile" },
	version = "*",
	init = function()
		-- Disable defaults so we can set custom gz-prefixed keymaps
		vim.g.nvim_surround_no_mappings = true
	end,
	config = function()
		require("nvim-surround").setup({})

		-- Custom keymaps using gz prefix (instead of default ys/ds/cs)
		local map = vim.keymap.set
		map("i", "<C-g>z", "<Plug>(nvim-surround-insert)", { desc = "Surround insert" })
		map("i", "<C-g>Z", "<Plug>(nvim-surround-insert-line)", { desc = "Surround insert line" })
		map("n", "gz", "<Plug>(nvim-surround-normal)", { desc = "Surround add" })
		map("n", "gZ", "<Plug>(nvim-surround-normal-cur)", { desc = "Surround add (current line)" })
		map("n", "gzgz", "<Plug>(nvim-surround-normal-line)", { desc = "Surround add (new lines)" })
		map("n", "gZgZ", "<Plug>(nvim-surround-normal-cur-line)", { desc = "Surround add cur (new lines)" })
		map("x", "gz", "<Plug>(nvim-surround-visual)", { desc = "Surround visual" })
		map("x", "gZ", "<Plug>(nvim-surround-visual-line)", { desc = "Surround visual line" })
		map("n", "gzd", "<Plug>(nvim-surround-delete)", { desc = "Surround delete" })
		map("n", "gzc", "<Plug>(nvim-surround-change)", { desc = "Surround change" })
		map("n", "gzC", "<Plug>(nvim-surround-change-line)", { desc = "Surround change line" })
	end,
}
