return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		-- add any options here
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify", -- Notify configuration handled in it's own .lua file
	},

	config = function()
		require("noice").setup({
			-- Disable file written notification
			-- routes = {
			-- 	{
			-- 		filter = {
			-- 			event = "msg_show",
			-- 			kind = "",
			-- 			find = "written",
			-- 		},
			-- 		opts = { skip = true },
			-- 	},
			-- },

			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},

			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = false, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
		})

		vim.keymap.set("n", "<leader>pn", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss current notifications" })

		-- Muted cmdline popup accent (border, icon, title) instead of default blue
		local cmdline_accent = "#C2C2C2"
		vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = cmdline_accent })
		vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle", { fg = cmdline_accent })
		vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { fg = cmdline_accent })
	end,
}
