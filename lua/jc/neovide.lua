-- Neovide options
vim.o.guifont = "IBM Plex Mono:h11" -- Set font for Neovide

-- Padding
local window_padding = 20
vim.g.neovide_padding_top = window_padding
vim.g.neovide_padding_bottom = window_padding
vim.g.neovide_padding_right = window_padding
vim.g.neovide_padding_left = window_padding

-- vim.g.neovide_normal_opacity = 0.6
vim.g.neovide_opacity = 0.5
vim.g.transparency = 0.9

-- Floating windows
vim.g.neovide_floating_corner_radius = 0.4
vim.g.neovide_floating_blur_amount_x = 4
vim.g.neovide_floating_blur_amount_y = 4

local floating_window_transparency = 80

vim.o.winblend = floating_window_transparency -- Set transparency for floating windows
vim.o.pumblend = floating_window_transparency -- Set transparency for popup menus

-- Cursor options
vim.g.neovide_cursor_animation_length = 0.075
vim.g.neovide_cursor_trail_size = 0
vim.g.neovide_cursor_animate_command_line = false -- Does not work with noice cmdline

-- Cursor blinking animation
vim.opt.guicursor = "n:block-blinkwait1000-blinkon500-blinkoff500,i:ver25-blinkwait500-blinkon500-blinkoff500"
vim.g.neovide_cursor_smooth_blink = true

---- Neovide only keymaps
-- Clipboard keymaps
vim.keymap.set({ "n", "v" }, "<C-S-V>", '"+p', { desc = "Paste system clipboard" })
vim.keymap.set("i", "<C-S-V>", '<esc>"+pa', { desc = "Paste system clipboard" })
vim.keymap.set("n", "<C-S-C>", '"+y', { desc = "Copy system clipboard" })

-- General keymaps
vim.keymap.set("i", "<C-BS>", "<C-w>", { desc = "Delete word backward in insert mode" })

-- Simple floating window transparency system
vim.api.nvim_create_autocmd({ "WinNew", "BufWinEnter" }, {
	callback = function()
		vim.schedule(function()
			local win = vim.api.nvim_get_current_win()
			local buf = vim.api.nvim_win_get_buf(win)
			local config = vim.api.nvim_win_get_config(win)

			-- Apply transparency to floating windows and specific plugin types
			if config.relative ~= "" or vim.bo[buf].buftype == "terminal" then
				vim.api.nvim_win_set_option(win, "winblend", floating_window_transparency)
			end
		end)
	end,
})
