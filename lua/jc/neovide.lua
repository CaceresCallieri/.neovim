-- Neovide options
vim.o.guifont = "IBM Plex Mono:h13" -- Set font for Neovide

vim.g.neovide_opacity = 0.7

-- Floating windows
vim.g.neovide_floating_corner_radius = 0.4
vim.g.neovide_floating_blur_amount_x = 2.5
vim.g.neovide_floating_blur_amount_y = 2.5

vim.o.winblend = 90 -- Set transparency for floating windows
vim.o.pumblend = 90 -- Set transparency for popup menus

-- Cursor options
vim.g.neovide_cursor_animation_length = 0.05
vim.g.neovide_cursor_trail_size = 0
vim.g.neovide_cursor_animate_command_line = false -- FIX: Does not work
-- vim.g.neovide_cursor_smooth_blink = true -- TODO: Add relevant options to make this work

-- Neovide only keymaps
vim.keymap.set({ "n", "v" }, "<C-S-V>", '"+p', { desc = "Paste system clipboard" })
vim.keymap.set("i", "<C-S-V>", '<esc>"+pa', { desc = "Paste system clipboard" })
vim.keymap.set("n", "<C-S-C>", '"+y', { desc = "Copy system clipboard" })

-- Set up plugin floating windows winblend to match Neovide's transparency
local lazygit_installed = pcall(require, "lazygit")
if lazygit_installed then
	vim.g.lazygit_floating_window_winblend = floating_window_transparency -- Example: set transparency to 20
end

local yazi_installed = pcall(require, "yazi")
if yazi_installed then
	require("yazi").setup({
		yazi_floating_window_winblend = 90, -- Set your desired transparency
	})
end
