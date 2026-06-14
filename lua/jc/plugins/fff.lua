return {
	"dmtrKovalenko/fff.nvim",
	-- Build the Rust backend (downloads prebuilt binary or compiles from source)
	build = function()
		require("fff.download").download_or_build_binary()
	end,
	lazy = false, -- Plugin initializes itself lazily internally
	opts = function()
		-- fff's `base_path` is the root its Rust `notify` backend indexes AND
		-- recursively watches. It defaults to `vim.fn.getcwd()` (conf.lua), and
		-- the backend has NO ignore-glob config (only `max_results`); it honors
		-- `.gitignore` only when rooted inside a repo. So launching nvim from
		-- $HOME makes it recursively watch the whole home tree
		-- (.cache/.steam/browser profiles) → an inotify event storm that pinned
		-- ~6 cores at 88 °C (relay 20260614). Root at the git toplevel instead;
		-- fall back to an inert scratch dir when not in a repo (e.g. nvim — or
		-- the Symmetria IDE's embedded nvim — launched from $HOME).
		local function watch_root()
			local cwd = vim.fn.getcwd()
			local marker = vim.fs.find(".git", { path = cwd, upward = true })[1]
			if marker then
				return vim.fs.dirname(marker)
			end
			if cwd == vim.env.HOME or cwd == "/" then
				local scratch = vim.fn.stdpath("cache") .. "/fff_scratch"
				vim.fn.mkdir(scratch, "p")
				return scratch
			end
			return cwd
		end
		return {
			base_path = watch_root(),
			-- Enable debug mode to help diagnose any issues
			debug = {
				enabled = true,
				show_scores = true,
			},
		}
	end,
	-- Define keybindings using lazy.nvim's keys table
	keys = {
		-- Primary file finding shortcuts (replaces Telescope file finding)
		{
			"<C-f>",
			function()
				require("fff").find_files()
			end,
			desc = "FFF find files in current directory",
		},
		{
			"<leader>ff",
			function()
				require("fff").find_files()
			end,
			desc = "FFF find files in current directory",
		},
		-- Find files in git root
		{
			"<leader>fF",
			function()
				require("fff").find_in_git_root()
			end,
			desc = "FFF find files in git root",
		},
		-- Refresh file index manually if needed
		{
			"<leader>fr",
			function()
				require("fff").scan_files()
			end,
			desc = "FFF refresh file index",
		},
	},
}
