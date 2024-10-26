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
		keymap.set("n", "<leader>pc", "", { desc = "Colorizer" }) -- Indicator
		keymap.set("n", "<leader>pct", ":ColorizerToggle<CR>", { desc = "Toggle Colorizer in current buffer" })
		keymap.set(
			"n",
			"<leader>pcr",
			":ColorizerAttachToBuffer<CR>",
			{ desc = "Attach to buffer, when it's already attached, reload current buffer" }
		)
	end,
}
