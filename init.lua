require("jc.core")
require("jc.lazy")
if vim.g.neovide then
	require("jc.neovide")
end

-- For TMUX, allows tmux-windows-name plugin to remane tmux window when opening and closing neovim instances
local uv = vim.loop

vim.api.nvim_create_autocmd({ "VimEnter", "VimLeave" }, {
	callback = function()
		if vim.env.TMUX_PLUGIN_MANAGER_PATH then
			uv.spawn(vim.env.TMUX_PLUGIN_MANAGER_PATH .. "/tmux-window-name/scripts/rename_session_windows.py", {})
		end
	end,
})
