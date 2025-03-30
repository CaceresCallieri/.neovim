vim.cmd("let g:netrw_liststyle = 3")

-- TODO: Remove in line diagnostic messages as they are made redundant by the virtual lines
vim.diagnostic.config({ virtual_text = false, virtual_lines = true })

-- TODO: Apply only to hover windows ("K")
-- vim.o.winborder = "rounded" -- Doesn't play nice with plugins windows, wait for fixes, try later on

local opt = vim.opt

opt.relativenumber = true
opt.number = true -- Show absolute number on current line

opt.conceallevel = 1 -- Required for obsidian.nvim

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = true
opt.breakindent = true

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- Appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- Center cursor by x lines
opt.scrolloff = 15

-- Prevent "o" and "O" from opening a new line commented
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		vim.opt.formatoptions:remove("o")
	end,
})

-- Neovide options
if vim.g.neovide then
	vim.g.neovide_cursor_animation_length = 0.1
	vim.g.neovide_cursor_trail_size = 0
	vim.g.neovide_cursor_animate_command_line = false
	vim.g.neovide_cursor_smooth_blink = true -- TODO: Add relevant options to make this work

	-- Neovide only keymaps
	vim.keymap.set("n", "<C-S-V>", '"+p', { desc = "Paste system clipboard" })
	-- vim.keymap.set("n", "<C-S-C>", '"+y', { desc = "Copy system clipboard" })
end
