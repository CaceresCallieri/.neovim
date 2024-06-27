return {
	{
		"tiagovla/tokyodark.nvim",
		priority = 1000, -- Makes sure the theme is loaded first.
		opts = {
			-- custom options here
		},
		config = function(_, opts)
			require("tokyodark").setup(opts) -- calling setup is optional
			vim.cmd([[colorscheme tokyodark]])
		end,
	},
}
