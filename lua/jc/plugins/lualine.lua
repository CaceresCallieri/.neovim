return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")

		-- Theme: Kanagawa Wave
		local colors = {
			blue = "#80a0ff",
			cyan = "#7FB4CA",
			black = "#232323",
			white = "#C2C2C2",
			red = "#FF5D62",
			violet = "#786794",
			grey = "#303030",
		}

		-- No background for transparency
		local custom_theme = {
			normal = {
				a = { fg = colors.white, bg = nil },
				b = { fg = colors.white, bg = nil },
				c = { fg = colors.white, bg = nil },
			},

			insert = { a = { fg = colors.white, bg = nil } },
			visual = { a = { fg = colors.white, bg = nil } },
			replace = { a = { fg = colors.white, bg = nil } },

			inactive = {
				a = { fg = colors.white, bg = nil },
				b = { fg = colors.white, bg = nil },
				c = { fg = colors.white },
			},
		}

		-- configure lualine with modified theme
		lualine.setup({
			options = {
				theme = custom_theme,
				component_separators = "",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_x = {},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = { "filename" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = { "location" },
			},
			tabline = {},
			extensions = {},
		})

		-- Set StatusLine to be transparent
		vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
		vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
	end,
}
