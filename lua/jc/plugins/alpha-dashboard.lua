return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Set header
		dashboard.section.header.val = { "Welcome back" }

		-- Set menu
		dashboard.section.buttons.val = {}

		-- Send config to alpha
		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])

		-- Always run alpha, even when there is an specified directory as a command argument
		vim.cmd("Alpha")
	end,
}
