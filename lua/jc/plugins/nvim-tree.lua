return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- Dynamically get active viewport size
		local function get_viewport()
			local ui = vim.api.nvim_list_uis()[1]
			return { width = ui.width, height = ui.height }
		end

		nvimtree.setup({
			view = {
				relativenumber = true,

				float = {
					enable = true,
					-- Get viewport dinamically to avoid outdated viewport sizes values
					open_win_config = function()
						local viewport = get_viewport()

						return {
							relative = "editor", -- Ensures the float is relative to the editor
							width = 40,
							height = viewport.height, -- TODO: Height fit content?
							col = viewport.width, -- Place floating window to the left of the screen
							row = 0,
							border = "rounded",
						}
					end,
				},
			},
			-- change folder arrow icons
			renderer = {
				indent_markers = {
					enable = true,
				},
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "►", -- arrow when folder is closed
							arrow_open = "▼", -- arrow when folder is open
						},
					},
				},
			},
			-- disable window_picker for
			-- explorer to work well with
			-- window splits
			actions = {
				open_file = {
					quit_on_open = true,
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = { ".DS_Store" },
			},
			git = {
				ignore = false,
			},
		})
		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set(
			"n",
			"<leader>ee",
			"<cmd>NvimTreeFindFileToggle<CR>",
			{ desc = "Toggle nvim-tree on current file" } -- This is the "default" option
		)
		keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle nvim-tree" })
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse nvim-tree" })
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh nvim-tree" })
	end,
}
