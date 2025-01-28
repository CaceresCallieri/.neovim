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

		vim.keymap.set("n", "<leader>pct", ":ColorizerToggle<CR>", { desc = "Toggle Colorizer in current buffer" })
		vim.keymap.set(
			"n",
			"<leader>pcr",
			":ColorizerAttachToBuffer<CR>",
			{ desc = "Attach to buffer, when it's already attached, reload current buffer" }
		)
	end,
}
