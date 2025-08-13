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

		-- Only run Alpha if no file arguments were provided AND no session is being restored
		local should_run_alpha = true

		-- Check for file arguments
		for i = 0, vim.fn.argc() - 1 do
			local arg = vim.fn.argv(i)
			if vim.fn.filereadable(arg) == 1 then
				should_run_alpha = false
				break
			end
		end

		-- Check if a session is being restored
		if should_run_alpha and vim.v.this_session ~= "" then
			should_run_alpha = false
		end

		-- Also check for -S flag in command line arguments
		if should_run_alpha then
			local cmdline = vim.fn.join(vim.v.argv, " ")
			if string.match(cmdline, "%-S%s+") then
				should_run_alpha = false
			end
		end

		if should_run_alpha then
			vim.cmd("Alpha")
		end
	end,
}
