return {
	-- "cacerescallieri/wine_theme.nvim",
	name = "wine_theme",
	dir = "/home/jc/.config/nvim/lua/jc/plugins/theme/wine_theme",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd("colorscheme wine_theme")
	end,
}
