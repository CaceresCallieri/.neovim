-- Neovide options
vim.o.guifont = "IBM Plex Mono:h12" -- Set font for Neovide

vim.g.neovide_opacity = 0.7

-- Floating windows
vim.g.neovide_floating_corner_radius = 0.4
vim.g.neovide_floating_blur_amount_x = 4
vim.g.neovide_floating_blur_amount_y = 4

local floating_window_transparency = 80

vim.o.winblend = floating_window_transparency -- Set transparency for floating windows
vim.o.pumblend = floating_window_transparency -- Set transparency for popup menus

-- Cursor options
vim.g.neovide_cursor_animation_length = 0.05
vim.g.neovide_cursor_trail_size = 0
vim.g.neovide_cursor_animate_command_line = false -- Does not work with noice cmdline

vim.opt.guicursor = "n:block-blinkwait1000-blinkon500-blinkoff500,i:ver25-blinkwait500-blinkon500-blinkoff500"
vim.g.neovide_cursor_smooth_blink = true

---- Neovide only keymaps
-- Clipboard keymaps
vim.keymap.set({ "n", "v" }, "<C-S-V>", '"+p', { desc = "Paste system clipboard" })
vim.keymap.set("i", "<C-S-V>", '<esc>"+pa', { desc = "Paste system clipboard" })
vim.keymap.set("n", "<C-S-C>", '"+y', { desc = "Copy system clipboard" })

-- General keymaps
vim.keymap.set("i", "<C-BS>", "<C-w>", { desc = "Delete word backward in insert mode" })

-- Set up plugin floating windows winblend to match Neovide's transparency
local lazygit_installed = pcall(require, "lazygit")
if lazygit_installed then
	vim.g.lazygit_floating_window_winblend = floating_window_transparency
end

local yazi_installed = pcall(require, "yazi")
if yazi_installed then
	require("yazi").setup({
		yazi_floating_window_winblend = floating_window_transparency,
	})
end
