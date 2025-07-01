return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

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

			insert = { a = { fg = colors.black, bg = nil } },
			visual = { a = { fg = colors.black, bg = nil } },
			replace = { a = { fg = colors.black, bg = nil } },

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
				lualine_a = { { "mode", right_padding = 2 } },
				lualine_b = { "filename", "branch" },
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = colors.cyan },
					},
				},
				lualine_y = { "filetype", "progress" },
				lualine_z = {
					{ "location", left_padding = 2 },
				},
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
