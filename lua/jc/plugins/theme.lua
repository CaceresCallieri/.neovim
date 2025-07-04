return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("kanagawa").setup({
			-- If you enable compilation, make sure to run :KanagawaCompile command every time you make changes to your config.
			compile = false, -- enable compiling the colorscheme
			undercurl = true, -- enable undercurls
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = {},
			transparent = false, -- do not set background color
			dimInactive = false, -- dim inactive window `:h hl-NormalNC`
			terminalColors = true, -- define vim.g.terminal_color_{0,17}

			colors = { -- add/modify theme and palette colors
				palette = {
					-- Fg and comments
					oldWhite = "#D0D0C0",
					fujiWhite = "#E0E0D0",

					-- Bg Shades
					sumiInk0 = "#16161B",
					sumiInk1 = "#18181E",
					sumiInk2 = "#1a1a20",
					sumiInk3 = "#000000", -- Wave, Dragon background
					sumiInk4 = "#2A2A35",
					sumiInk5 = "#464646", -- Cursor Line background

					sumiInk6 = "#54546B", --fg

					-- Accent color
					carpYellow = "#C2C2C2",
				},
				theme = {
					all = {
						ui = {
							bg_gutter = "none", -- Disable different background color in Line Numbers
						},
					},
				},
			},

			overrides = function(colors)
				local theme = colors.theme
				return {
					-- Transparent floating windows
					NormalFloat = { bg = "none" },
					FloatBorder = { bg = "none" },
					FloatTitle = { bg = "none" },

					-- Dark completion (popup) menu
					Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparencyel = { fg = "NONE", bg = theme.ui.bg_p2 },
					PmenuSbar = { bg = theme.ui.bg_m1 },
					PmenuThumb = { bg = theme.ui.bg_p2 },

					-- Borderless telescope, if no background is specified, inherints transparent if true
					TelescopeTitle = { fg = theme.ui.special, bold = true },
					-- TelescopePromptNormal = { bg = theme.ui.bg_p1 },
					TelescopePromptBorder = { fg = "#C2C2C2" },
					TelescopeResultsNormal = { fg = theme.ui.fg_dim },
					TelescopeResultsBorder = { fg = "#C2C2C2" },
					-- TelescopePreviewNormal = { bg = theme.ui.bg_dim },
					TelescopePreviewBorder = { fg = "#C2C2C2" },

					-- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
					NormalDark = { fg = theme.ui.fg_dim, bg = "none" },

					-- Popular plugins that open floats will link to NormalFloat by default;
					-- set their background accordingly if you wish to keep them dark and borderless
					LazyNormal = { fg = theme.ui.fg_dim },
					MasonNormal = { fg = theme.ui.fg_dim },
				}
			end,

			theme = "dragon", -- Load theme when 'background' option is not set
			-- background = { -- map the value of 'background' option to a theme
			-- 	dark = "dragon",
			-- 	light = "wave",
			-- },
		})

		-- setup must be called before loading
		vim.cmd("colorscheme kanagawa")

		require("kanagawa").load("wave")
	end,
}
