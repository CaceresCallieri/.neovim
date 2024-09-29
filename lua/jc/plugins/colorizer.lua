return {
	"norcalli/nvim-colorizer.lua",
	config = function()
		local colorizer = require("colorizer")

		colorizer.setup({
			"*", -- Highlight all files, but customize some others.
			css = {
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
			},
		})

		local keymap = vim.keymap
		keymap.set("n", "<leader>pc", ":ColorizerToggle<CR>", { desc = "Toggle Colorizer in current buffer" })
	end,
}
