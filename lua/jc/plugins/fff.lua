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
			-- No repo here: refuse $HOME and ANY ancestor of it (/, /home, ...)
			-- as a watch root — recursively watching from there covers the
			-- whole home tree and pins the CPU. A narrower non-git dir (a real
			-- project that just isn't versioned) is still indexed directly.
			local home = vim.env.HOME
			if cwd == "/" or cwd == home or home:sub(1, #cwd + 1) == cwd .. "/" then
				local scratch = vim.fn.stdpath("cache") .. "/fff_scratch"
				if vim.fn.isdirectory(scratch) == 0 then
					vim.fn.mkdir(scratch, "p")
				end
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
