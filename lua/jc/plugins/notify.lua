return {
	"rcarriga/nvim-notify",

	config = function()
		require("notify").setup({
			merge_duplicates = true,
			timeout = 2000,
			fps = 75,
			top_down = false,
			render = "compact",
			stages = "slide",
		})
	end,
}
