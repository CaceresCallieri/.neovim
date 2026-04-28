-- Layout manager for sidebar windows.
-- Reserves a fixed-width slot on the right edge for neo-tree (filesystem
-- and git_status sources share the slot via filetype matching).
-- Replaces the previous WinClosed placeholder hack — edgy enforces the
-- layout invariant declaratively.
return {
	"folke/edgy.nvim",
	lazy = false, -- Load eagerly so the right edge is available before VimEnter
	priority = 1000, -- Set up before plugins that may try to open windows
	init = function()
		-- Required for predictable edgy behavior:
		-- laststatus=3: single global statusline (avoids per-edge statuslines)
		-- splitkeep=screen: cursor stays put when splits change, no jumpy redraws
		vim.opt.laststatus = 3
		vim.opt.splitkeep = "screen"
	end,
	opts = {
		right = {
			{
				ft = "neo-tree",
				size = { width = 32 },
				-- Both filesystem and git_status sources match ft=neo-tree,
				-- so they automatically share this slot. <leader>at swaps between them.
			},
		},
		animate = {
			enabled = false, -- Off initially — animations can feel distracting in a coding loop
		},
		exit_when_last = false, -- Don't auto-quit nvim when only edgy windows remain
		wo = {
			winbar = false, -- Cleaner look — no per-window status above the tree
		},
	},
}
