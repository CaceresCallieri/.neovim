return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				winblend = 90,
				path_display = { "smart" },
				-- Enhanced ignore patterns to skip large directories and temp files
				file_ignore_patterns = {
					"node_modules",
					".git",
					"%.lock",
					"target/",
					"build/",
					"dist/",
					"%.cache",
					"%.tmp",
					"%.log",
				},
				-- Memory protection: limit cached pickers and entries to prevent RAM issues
				cache_picker = {
					num_pickers = 5,
					limit_entries = 1000,
				},
				-- Performance optimizations to prevent UI lag
				scroll_strategy = "limit",
				selection_strategy = "reset",
				sorting_strategy = "ascending",
				layout_strategy = "horizontal",
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-d>"] = actions.delete_buffer,
						["<C-q>"] = "close",
					},
					n = {
						["q"] = "close",
					},
				},
			},

			pickers = {
				-- File finding is now handled by FFF.nvim for better performance
				live_grep = {
					file_ignore_patterns = { "node_modules", ".git", "%.lock" },
					additional_args = function(_)
						return {
							"--hidden",
							"--follow", -- Keep symlink support
							"--max-depth=8", -- Limit directory traversal depth
							"--max-count=1000", -- Limit matches per file to prevent hang
						}
					end,
				},
			},

			-- Optimize fzf extension for better performance
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true, -- Use fzf for all sorting
					override_file_sorter = true, -- Use fzf for file sorting
					case_mode = "smart_case", -- Smart case matching
				},
			},
		})

		telescope.load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness
		local builtin = require("telescope.builtin")

		-- Shortcuts (file finding removed - now handled by FFF.nvim)
		keymap.set("n", "<C-b>", builtin.buffers, { desc = "Telescope buffers" })

		-- Leader keymaps (file finding removed - now handled by FFF.nvim)
		keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
		keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
		keymap.set("n", "<leader>fy", builtin.registers, { desc = "Telescope vim registers" })
		keymap.set("n", "<leader>fm", builtin.marks, { desc = "Telescope find marks" })
		keymap.set("n", "<leader>fT", builtin.help_tags, { desc = "Telescope help tags" })

		keymap.set("n", "<leader>fc", "", { desc = "Telescope current..." })
		keymap.set("n", "<leader>fcs", builtin.grep_string, { desc = "Telescope grep string word under cursor" })
		keymap.set("n", "<leader>fcf", builtin.current_buffer_fuzzy_find, { desc = "Telescope inside current buffer" })

		keymap.set("n", "<leader>fh", "", { desc = "Telescope histories..." })
		keymap.set("n", "<leader>fhc", builtin.command_history, { desc = "Telescope command history" })
		keymap.set("n", "<leader>fhs", builtin.search_history, { desc = "Telescope search history" })
	end,
}
