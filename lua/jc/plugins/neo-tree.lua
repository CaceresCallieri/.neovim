-- Directories to skip when expanding all nodes
local skip_directories = {
	["node_modules"] = true,
	[".git"] = true,
	["dist"] = true,
	["build"] = true,
	["target"] = true,
	["__pycache__"] = true,
	[".venv"] = true,
	["vendor"] = true,
}

-- Max recursion depth for auto-expansion. depth=0 is the project root, so
-- with 7 we expand seven levels of folder structure and leave deeper trees
-- collapsed (visible but un-walked). Tunable: raise for deeper monorepos,
-- lower if indentation feels noisy.
local MAX_EXPAND_DEPTH = 7

-- Source-agnostic trigger for the expand-all command. Used by both the
-- neo-tree internal event_handler (first open) and the BufWinEnter autocmd
-- (reopen / source swap), so behavior stays consistent regardless of how
-- the tree window came into existence.
--
-- Implementation note: neo-tree's `node:expand()` only marks a node as
-- expanded; children are fetched on the next render. So a single recursive
-- pass can only expand nodes whose children are already loaded — at startup,
-- that's typically depth 0 and 1 only. We fire multiple passes at increasing
-- delays so each pass picks up the children loaded by the previous pass,
-- cascading the expansion down to MAX_EXPAND_DEPTH over ~1 second. Each pass
-- is idempotent (already-expanded nodes are skipped), so re-runs are cheap.
local function trigger_auto_expand(source_name)
	-- Single deferred call. The expand_all_nodes_filtered command runs its
	-- recursion inside async.run and uses neo-tree's filesystem prefetcher to
	-- synchronously load child directories before recursing — no cascade or
	-- retry loop needed. The 50ms defer just lets the tree window finish
	-- registering its state before we touch it.
	vim.defer_fn(function()
		local ok, manager = pcall(require, "neo-tree.sources.manager")
		if not ok then
			return
		end
		local state = manager.get_state(source_name)
		if not state or not state.tree then
			return
		end
		local commands = require("neo-tree").config.commands
		if commands and commands.expand_all_nodes_filtered then
			commands.expand_all_nodes_filtered(state)
		end
	end, 50)
end

-- Find the source of the neo-tree window in the current tab, or nil if closed.
-- vim.b[buf].neo_tree_source is set by neo-tree itself on each tree buffer.
local function find_neotree_source()
	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].filetype == "neo-tree" then
			return vim.b[buf].neo_tree_source
		end
	end
	return nil
end

-- Symmetric smart-toggle: pressing the key for the *active* source closes the
-- sidebar; pressing it for any other state (closed or other source) shows the
-- target source. Lets a single key act as both "open this view" and "close it."
--
-- When swapping sources, close the existing tree first. Otherwise neo-tree
-- opens the target as a *new* window while the old one lingers briefly,
-- and edgy reserves slot space for both — leaving a phantom gap in the layout.
local function smart_toggle(target_source)
	return function()
		local current = find_neotree_source()
		if current then
			vim.cmd("Neotree close")
		end
		if current ~= target_source then
			vim.cmd("Neotree show " .. target_source)
		end
	end
end

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons", -- optional, but recommended
	},
	lazy = false, -- neo-tree will lazily load itself
	config = function(_, opts)
		require("neo-tree").setup(opts)

		-- Real-time git_status refresh: fire neo-tree's git_event whenever
		-- repo state likely changed. CursorHold covers the "agent edits while
		-- I'm idle in nvim" case (fires after &updatetime ms of inactivity).
		local events = require("neo-tree.events")
		local refresh_group = vim.api.nvim_create_augroup("NeoTreeGitRefresh", { clear = true })
		vim.api.nvim_create_autocmd({
			"BufWritePost", -- nvim-side save
			"FocusGained", -- returning from external window
			"TermLeave", -- leaving an embedded terminal (agent finished a turn)
			"CursorHold", -- idle tick for ambient updates
		}, {
			group = refresh_group,
			callback = function()
				-- Skip refresh when cursor is inside the neo-tree buffer itself:
				-- redrawing while interacting with the tree can jump the cursor or
				-- interrupt type-ahead in the filter prompt.
				if vim.bo.filetype == "neo-tree" then
					return
				end
				events.fire_event(events.GIT_EVENT)
			end,
		})

		-- Re-trigger auto-expansion every time a neo-tree buffer is shown in a
		-- window — covers reopen-after-close and source swaps (filesystem ↔
		-- git_status), where the neo_tree internal "after_open" event is
		-- unreliable. Idempotent: already-expanded nodes are skipped, so the
		-- only cost on no-op runs is a cheap tree walk.
		local autoexpand_group = vim.api.nvim_create_augroup("NeoTreeAutoExpand", { clear = true })
		vim.api.nvim_create_autocmd("BufWinEnter", {
			group = autoexpand_group,
			callback = function(ev)
				if vim.bo[ev.buf].filetype ~= "neo-tree" then
					return
				end
				local source = vim.b[ev.buf].neo_tree_source
				if not source then
					return
				end
				-- trigger_auto_expand handles its own cascading delays
				trigger_auto_expand(source)
			end,
		})

		-- Auto-open the filesystem sidebar at startup. `<C-g>` swaps to
		-- git_status on demand. Predictable default beats clever heuristics —
		-- the user always knows what they'll see when they open nvim.
		local startup_group = vim.api.nvim_create_augroup("NeoTreeStartup", { clear = true })
		vim.api.nvim_create_autocmd("VimEnter", {
			group = startup_group,
			once = true,
			callback = function()
				-- Defer one tick so edgy and the dashboard finish their own setup first
				vim.schedule(function()
					-- Only open the sidebar when nvim launched without a file argument.
					-- When a file is passed (e.g. `nvim foo.lua`), the sidebar opening
					-- alongside it is intrusive — the user's intent is to edit that file.
					if vim.fn.argc() > 0 then
						return
					end
					-- `show` opens without stealing focus from the dashboard / current window
					vim.cmd("Neotree show filesystem")
				end)
			end,
		})
	end,
	opts = {
		filesystem = {
			-- Dashboard integration: prevents neo-tree from hijacking directory buffers at startup
			-- Related: options.lua (clears arglist), snacks.lua (dashboard shows instead)
			hijack_netrw_behavior = "disabled",
			-- Detect external file create/delete (e.g. agent writing files via terminal)
			use_libuv_file_watcher = true,
		},
		window = {
			position = "right", -- Right-side sidebar, slot reserved by edgy.nvim
			width = 32, -- Initial width; edgy enforces it as the pinned size
			mappings = {
				["z"] = "expand_all_nodes_filtered", -- Expand all folders except skip list
				["Z"] = "close_all_nodes", -- Collapse all folders
			},
		},
		commands = {
			-- Expand all directories except those in the skip list, capped at
			-- MAX_EXPAND_DEPTH. Mirrors neo-tree's own expand_all_nodes algorithm
			-- (sources/common/node_expander.lua) but with two filters added at
			-- the right spot: depth limit and skip-list. The recursion runs
			-- inside async.run, so prefetcher.prefetch() yields the coroutine
			-- until the filesystem scan completes — children are reliably
			-- populated by the time we recurse into them.
			expand_all_nodes_filtered = function(state)
				local renderer = require("neo-tree.ui.renderer")
				local utils = require("neo-tree.utils")
				local async = require("plenary.async")

				-- Resolve the source's prefetcher. Filesystem provides a real one
				-- that loads dir items synchronously; other sources (e.g.
				-- git_status) don't need prefetching since their data is flat.
				local prefetcher = nil
				if state.name == "filesystem" then
					local ok_fs, fs_source = pcall(require, "neo-tree.sources.filesystem")
					if ok_fs then
						prefetcher = fs_source.prefetcher
					end
				end

				local function recurse(node, depth)
					if depth > MAX_EXPAND_DEPTH then
						return
					end
					if skip_directories[node.name] then
						return
					end
					if not utils.is_expandable(node) then
						return
					end

					-- Synchronously load children if needed. Inside async.run this
					-- call yields; outside, it would no-op silently. That's the
					-- crux of why a non-async-run walker would fail — the prefetch
					-- can't yield, and tree:get_nodes() returns empty for any
					-- not-yet-loaded directory.
					if prefetcher and prefetcher.should_prefetch(node) then
						prefetcher.prefetch(state, node)
					end

					if not node:is_expanded() then
						node:expand()
						state.explicitly_opened_nodes[node:get_id()] = true
					end

					for _, child in ipairs(state.tree:get_nodes(node:get_id())) do
						recurse(child, depth + 1)
					end
				end

				state.explicitly_opened_nodes = state.explicitly_opened_nodes or {}
				renderer.position.set(state, nil)

				local root_nodes = state.tree:get_nodes()

				async.run(function()
					for _, root in ipairs(root_nodes) do
						recurse(root, 0)
					end
				end, function()
					renderer.redraw(state)
				end)
			end,
		},
		event_handlers = {
			{
				event = "neo_tree_window_after_open",
				handler = function(args)
					-- Use the source name from the event args so this works for any
					-- source (filesystem, git_status, future ones). The cascading
					-- helper handles its own timing — no outer defer needed.
					local source_name = (args and args.source_name) or "filesystem"
					trigger_auto_expand(source_name)
				end,
			},
		},
	},
	keys = {
		{
			"<C-e>",
			smart_toggle("filesystem"),
			desc = "File tree (close if active, show otherwise)",
		},
		{
			"<C-g>",
			smart_toggle("git_status"),
			desc = "Git status tree (close if active, show otherwise)",
		},
	},
}
