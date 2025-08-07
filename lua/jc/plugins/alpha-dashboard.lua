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

		-- Only run Alpha if no file arguments were provided
		for i = 0, vim.fn.argc() - 1 do
			local arg = vim.fn.argv(i)
			if vim.fn.filereadable(arg) ~= 1 then
				vim.cmd("Alpha")
				break
			end
		end
	end,
}
