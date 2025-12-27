return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")

		local colors = {
			white = "#C2C2C2",
			black = "#1A1A1A",
			yellow = "#FDD886",
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
			terminal = {
				a = { fg = colors.black, bg = colors.yellow },
				z = { fg = colors.white, bg = nil },
			},

			inactive = {
				a = { fg = colors.white, bg = nil },
				b = { fg = colors.white, bg = nil },
				c = { fg = colors.white },
			},
		}

		-- Custom location component showing line:column/total_lines
		local function custom_location()
			return string.format("%d:%d/%d", vim.fn.line("."), vim.fn.col("."), vim.fn.line("$"))
		end

		-- Approximate token count based on character count
		-- Uses the heuristic: ~4 characters per token (common for English text)
		local function approx_token_count()
			local buf = vim.api.nvim_get_current_buf()
			local line_count = vim.api.nvim_buf_line_count(buf)

			-- Get total character count efficiently
			local char_count = vim.api.nvim_buf_get_offset(buf, line_count)

			-- Approximate tokens (4 chars ≈ 1 token)
			local tokens = math.floor(char_count / 4)

			local token_symbol = nil

			-- Format with 'k' suffix for thousands
			if tokens >= 1000 then
				return string.format(token_symbol .. "%.1fk", tokens / 1000)
			else
				return token_symbol .. tostring(tokens)
			end
		end

		-- Get the project root folder name (last component of cwd)
		local function project_root()
			return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
		end

		local modified_file_indicator = "●"

		-- configure lualine with modified theme
		lualine.setup({
			options = {
				theme = custom_theme,
				component_separators = "",
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { { "mode", separator = { left = "", right = "" }, right_padding = 2 } },
				lualine_b = { project_root, "branch" },
				lualine_c = {
				{
					"filename",
					path = 1,
					symbols = { modified = modified_file_indicator },
					-- Hide filename for terminal buffers
					cond = function()
						return vim.bo.buftype ~= "terminal"
					end,
				},
			},
				lualine_w = {},
				lualine_x = {},
				lualine_y = { approx_token_count },
				lualine_z = { custom_location },
			},
			inactive_sections = {
				lualine_a = { { "filename", path = 1, symbols = { modified = modified_file_indicator } } },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = { custom_location },
			},
			tabline = {},
			extensions = {},
		})

		-- Set StatusLine to be transparent
		vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
		vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
	end,
}
