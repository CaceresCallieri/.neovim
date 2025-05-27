-- snacks.indent
return {
	"folke/snacks.nvim",
	opts = {
		indent = {
			indent = {
				enabled = false,
			},
			animate = {
				style = "out",
				easing = "linear",
				duration = {
					total = 250,
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
