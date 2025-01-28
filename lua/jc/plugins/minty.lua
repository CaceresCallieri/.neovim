return {
	"nvzone/minty",
	lazy = true,
	dependencies = "nvzone/volt",
	cmd = { "Shades", "Huefy" },

	vim.keymap.set("n", "<leader>pch", "<cmd>Huefy<CR>", { desc = "Pop up Minty's Hue window" }),
	vim.keymap.set("n", "<leader>pcs", "<cmd>Shades<CR>", { desc = "Pop up Minty's Shades window" }),
}
