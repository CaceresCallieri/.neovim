local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ import = "jc.plugins" },
	{ import = "jc.plugins.lsp" },
	{ import = "jc.plugins.theme" },
}, {
	dev = {
		path = "~/Dev", -- Where local dev plugins live
		patterns = {}, -- Use for all plugins with dev = true
		fallback = false, -- Don't fallback to git
	},
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})
