return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	opts = {
		options = {
			mode = "tabs",
			separator_style = "thin",
			-- Avoid showing bufferline when there's only one tab
			always_show_bufferline = false,
			auto_toggle_bufferline = true,
			-- Disable close icons
			show_buffer_close_icons = false,
			show_close_icon = false,
			-- TODO: Indicate that a tab has multiple buffers open

			name_formatter = function(buf)
				if buf.name and buf.name:match("NvimTree") then
					return " File Tree"
				end
				return buf.name
			end,

			get_element_icon = function(element)
				-- Check if the buffer has a name and if it's NvimTree, set a custom icon
				if element.filetype and element.filetype:match("NvimTree") then
					return "" -- Change this to your preferred icon
				end
			end,
		},
	},
}
