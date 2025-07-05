-- snacks.indent
return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		indent = {
			indent = {
				enabled = false,
			},
			animate = {
				style = "out",
				easing = "linear",
				duration = {
					total = 300,
				},
			},
		},
		chunk = {
			enabled = true,
			char = {
				horizontal = "─",
				vertical = "│",
				corner_top = "┌",
				corner_bottom = "└",
				arrow = "─",
			},
		},
	},
}
