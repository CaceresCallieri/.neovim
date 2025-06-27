-- Neovide options
vim.o.guifont = "JetBrainsMono Nerd Font Mono:h12" -- Set font for Neovide

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
vim.keymap.set({ "i", "n" }, "<C-S-V>", '"+p', { desc = "Paste system clipboard" })
-- vim.keymap.set("n", "<C-S-C>", '"+y', { desc = "Copy system clipboard" })
