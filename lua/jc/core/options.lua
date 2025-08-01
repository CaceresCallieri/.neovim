-- Set directory given in nvim argument to current working directory
if vim.fn.argc() == 1 then
	local arg = vim.fn.argv(0)
	-- Ensure arg is a string, not an array
	if type(arg) == "string" then
		local stat = vim.loop.fs_stat(arg)
		if stat and stat.type == "directory" then
			vim.cmd("cd " .. arg)
		elseif stat and stat.type == "file" then
			vim.cmd("cd " .. vim.fn.fnamemodify(arg, ":h"))
		end
	end
end

local opt = vim.opt

opt.relativenumber = true
opt.number = true -- Show absolute number on current line

-- Show trailing whitespace as dots
-- Enable showing whitespace characters
opt.list = true
-- Show trailing spaces as a dot (·)
opt.listchars = { tab = "  ", trail = "·" }

-- tabs & indentation
opt.tabstop = 4 -- spaces for tabs (prettier default)
opt.shiftwidth = 4 -- spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = true
opt.breakindent = true

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = false -- highlight the current cursor line

--------- Appearance
-- turn on termguicolors
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

-- Center cursor by x amount of lines
opt.scrolloff = 15

opt.conceallevel = 1 -- Required for obsidian.nvim

-- Prevent "o" and "O" from opening a new line commented
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		opt.formatoptions:remove("o")
	end,
})

-- Show diagnostics in inline virtual text
-- Initial config: virtual_text on, virtual_lines off
vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		spacing = 1,
	},
	virtual_lines = false,
})

-- Highlighting options
vim.api.nvim_set_hl(0, "@keyword", { italic = true })
