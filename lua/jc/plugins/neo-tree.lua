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

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons", -- optional, but recommended
	},
	lazy = false, -- neo-tree will lazily load itself
	opts = {
		popup_border_style = "rounded", -- Rounded borders for floating window
		filesystem = {
			-- Dashboard integration: prevents neo-tree from hijacking directory buffers at startup
			-- Related: options.lua (clears arglist), snacks.lua (dashboard shows instead)
			hijack_netrw_behavior = "disabled",
		},
		window = {
			position = "float", -- Open as floating window instead of sidebar
			popup = {
				size = {
					height = "95%", -- Increased from default 80%
					width = "70%", -- Increased from default 50%
				},
				position = "50%", -- Keep window centered
			},
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
			"<cmd>Neotree toggle<cr>",
			desc = "Toggle Neo-tree floating window",
		},
	},
}
