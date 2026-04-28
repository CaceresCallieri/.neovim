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
		if current ~= nil then
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
			"BufWritePost",   -- nvim-side save
			"FocusGained",    -- returning from external window
			"TermLeave",      -- leaving an embedded terminal (agent finished a turn)
			"CursorHold",     -- idle tick for ambient updates
		}, {
			group = refresh_group,
			callback = function()
				events.fire_event(events.GIT_EVENT)
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
					-- `show` opens without stealing focus from the dashboard / current window
					vim.cmd("Neotree show filesystem")
				end)
			end,
		})
	end,
	opts = {
		popup_border_style = "rounded", -- Rounded borders for floating window
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
			-- Custom command that expands all nodes except directories in skip list
			expand_all_nodes_filtered = function(state)
				local renderer = require("neo-tree.ui.renderer")
				local utils = require("neo-tree.utils")
				local async = require("plenary.async")

				-- Recursive function to expand nodes, skipping filtered directories
				local function expand_node_filtered(node, tree, explicitly_opened)
					-- Skip if this directory is in the skip list
					if skip_directories[node.name] then
						return
					end

					-- Expand this node if it's expandable and not already expanded
					if utils.is_expandable(node) and not node:is_expanded() then
						node:expand()
						explicitly_opened[node:get_id()] = true
					end

					-- Recursively process children
					local children = tree:get_nodes(node:get_id())
					for _, child in ipairs(children) do
						if utils.is_expandable(child) then
							expand_node_filtered(child, tree, explicitly_opened)
						end
					end
				end

				-- Get all root nodes
				local root_nodes = state.tree:get_nodes()
				renderer.position.set(state, nil)
				state.explicitly_opened_nodes = state.explicitly_opened_nodes or {}

				local task = function()
					for _, root in ipairs(root_nodes) do
						expand_node_filtered(root, state.tree, state.explicitly_opened_nodes)
					end
				end

				async.run(task, function()
					renderer.redraw(state)
				end)
			end,
		},
		event_handlers = {
			{
				event = "neo_tree_window_after_open",
				handler = function()
					-- Use filtered expansion on window open
					vim.defer_fn(function()
						local manager = require("neo-tree.sources.manager")
						local state = manager.get_state("filesystem")
						if state and state.tree then
							local commands = require("neo-tree").config.commands
							if commands and commands.expand_all_nodes_filtered then
								commands.expand_all_nodes_filtered(state)
							end
						end
					end, 50)
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
