return {
	"norcalli/nvim-colorizer.lua",
	config = function()
		local colorizer = require("colorizer")

		colorizer.setup({
			"*", -- Highlight all files, but customize some others.
			css = { rgb_fn = true }, -- Enable parsing rgb(...) functions in css.
		})

		local keymap = vim.keymap
		keymap.set("n", "<leader>pc", ":ColorizerToggle<CR>", { desc = "Toggle Colorizer in current buffer" })
	end,
}
