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
				path_display = { "smart" },
				file_ignore_patterns = { "node_modules" },
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
				find_files = {
					hidden = true,
					follow = true, -- Allow symlinks to appear on search results
				},
				live_grep = {
					file_ignore_patterns = { "node_modules", ".git" },
					additional_args = function(_)
						return { "--hidden", "--follow" } -- Allow find string to search symlinks and hidden files
					end,
				},
			},
		})

		telescope.load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness
		local builtin = require("telescope.builtin")

		-- Shortcuts
		keymap.set("n", "<C-f>", builtin.find_files, { desc = "Telescope find files" })
		keymap.set("n", "<C-b>", builtin.buffers, { desc = "Telescope buffers" })

		-- Leader keymaps
		keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
		keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
		keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
		keymap.set("n", "<leader>fy", builtin.registers, { desc = "Telescope vim registers" })
		keymap.set("n", "<leader>fm", builtin.marks, { desc = "Telescope find marks" })
		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
		keymap.set("n", "<leader>fT", builtin.help_tags, { desc = "Telescope help tags" })

		keymap.set("n", "<leader>fc", "", { desc = "Telescope current..." })
		keymap.set("n", "<leader>fcs", builtin.grep_string, { desc = "Telescope grep string word under cursor" })
		keymap.set("n", "<leader>fcf", builtin.current_buffer_fuzzy_find, { desc = "Telescope inside current buffer" })

		keymap.set("n", "<leader>fh", "", { desc = "Telescope histories..." })
		keymap.set("n", "<leader>fhc", builtin.command_history, { desc = "Telescope command history" })
		keymap.set("n", "<leader>fhs", builtin.search_history, { desc = "Telescope search history" })
	end,
}
