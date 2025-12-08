return {
	-- TESTING: Using local fork with defensive fallbacks
	dir = "~/Dev/fyler.nvim",
	dependencies = { "nvim-mini/mini.icons" },
	opts = {
		views = {
			finder = {
				indentscope = {
					width = 4, -- TEST: Custom indent width
					marker = "",
				},
				mappings = {
					["E"] = function(self)
						print("DEBUG: E pressed - starting expand all")
						print("DEBUG: self.files exists:", self.files ~= nil)
						print("DEBUG: self.files.trie exists:", self.files and self.files.trie ~= nil)
						print("DEBUG: self.files.manager exists:", self.files and self.files.manager ~= nil)

						-- Directories to skip when expanding all
						local skip_directories = {
							[".git"] = true,
							["node_modules"] = true,
							[".venv"] = true,
							["__pycache__"] = true,
							["vendor"] = true,
							["dist"] = true,
							["build"] = true,
							[".cache"] = true,
						}

						-- Recursive function to expand all nodes in trie
						local function expand_all_in_trie(node, files)
							local entry = files.manager:get(node.value)
							-- Only expand this node if it's a valid directory entry
							-- Use entry.type == "directory" instead of entry:isdir() for compatibility
							if entry and entry.type == "directory" and not skip_directories[entry.name] then
								if not entry.open then
									files:expand_node(node.value)
								end
							end
							-- ALWAYS recurse into children
							for _, child in pairs(node.children) do
								expand_all_in_trie(child, files)
							end
						end

						-- Iteratively expand until no new directories found
						local function expand_iteration()
							print("DEBUG: expand_iteration called")
							local had_closed = false

							-- Check if any directories are closed (excluding skipped ones)
							local function check_closed(node, depth)
								depth = depth or 0
								local entry = self.files.manager:get(node.value)
								print(
									string.format(
										"DEBUG: check_closed depth=%d, node.value=%s, entry=%s, has_isdir=%s",
										depth,
										tostring(node.value),
										tostring(entry),
										tostring(entry and entry.isdir ~= nil)
									)
								)
								-- Debug: Show all keys in entry
								if entry and depth == 1 then
									print("DEBUG: Entry keys for first child:")
									for k, v in pairs(entry) do
										print(string.format("  %s = %s (%s)", tostring(k), tostring(v), type(v)))
									end
									-- Check metatable
									local mt = getmetatable(entry)
									if mt then
										print("DEBUG: Entry has metatable")
										if mt.__index then
											print("DEBUG: Metatable has __index")
										end
									else
										print("DEBUG: Entry has NO metatable")
									end
								end
								-- Only check this node if it's a valid directory entry
								-- Use entry.type == "directory" instead of entry:isdir() for compatibility
								if entry and entry.type == "directory" and not skip_directories[entry.name] then
									if not entry.open then
										print("DEBUG: Found closed dir:", entry.name)
										had_closed = true
									end
								end
								-- ALWAYS recurse into children
								local child_count = 0
								for _ in pairs(node.children) do
									child_count = child_count + 1
								end
								print(string.format("DEBUG: node has %d children", child_count))
								for _, child in pairs(node.children) do
									check_closed(child, depth + 1)
								end
							end
							check_closed(self.files.trie, 0)

							print("DEBUG: had_closed =", had_closed)
							if not had_closed then
								print("DEBUG: No closed dirs, dispatching refresh")
								self:dispatch_refresh()
								return
							end

							print("DEBUG: Expanding nodes...")
							expand_all_in_trie(self.files.trie, self.files)

							self.files:update(nil, function()
								vim.schedule(function()
									expand_iteration()
								end)
							end)
						end

						expand_iteration()
						print("DEBUG: E function completed")
					end,
				},
				win = {
					kind = "float",
					kinds = {
						float = {
							height = "90%",
							width = "70%",
						},
					},
				},
			},
		},
		win_opts = {
			concealcursor = "nvic",
			conceallevel = 3,
			cursorline = false,
			number = true,
			relativenumber = true,
			winhighlight = "Normal:FylerNormal,NormalNC:FylerNormalNC",
			wrap = false,
		},
	},
}
