-- Parsers to keep installed (installed on startup if missing)
local ensure_installed = {
	"json",
	"javascript",
	"typescript",
	"tsx",
	"yaml",
	"toml",
	"html",
	"css",
	"scss",
	"prisma",
	"markdown",
	"markdown_inline",
	"svelte",
	"graphql",
	"bash",
	"lua",
	"vim",
	"dockerfile",
	"gitignore",
	"query",
	"vimdoc",
	"c",
	"regex",
}

return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		{
			"windwp/nvim-ts-autotag",
			-- nvim-ts-autotag reads its config from opts.opts (its own plugin opts table),
			-- so the outer opts is for lazy.nvim and the inner opts is for the plugin itself.
			opts = {
				opts = {
					enable_close = true,
					enable_rename = true,
				},
			},
		},
	},
	config = function()
		require("nvim-treesitter").setup()

		-- Install any missing parsers from the ensure_installed list
		local installed = require("nvim-treesitter").get_installed()
		local missing = vim.tbl_filter(function(parser)
			return not vim.list_contains(installed, parser)
		end, ensure_installed)

		if #missing > 0 then
			require("nvim-treesitter").install(missing)
		end

		-- Enable treesitter-based highlighting and indentation for all filetypes
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true }),
			callback = function()
				pcall(vim.treesitter.start)
				if vim.bo.indentexpr == "" then
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})

		-- Incremental node selection via treesitter
		-- Starts visual selection on the node under cursor, then expands/shrinks
		local function get_node_at_cursor()
			local node = vim.treesitter.get_node()
			if not node then
				return nil
			end
			return node
		end

		vim.keymap.set("n", "<C-space>", function()
			local node = get_node_at_cursor()
			if not node then
				return
			end
			local sr, sc, er, ec = node:range()
			vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
			vim.cmd("normal! v")
			vim.api.nvim_win_set_cursor(0, { er + 1, ec > 0 and ec - 1 or 0 })
		end, { desc = "Init treesitter selection" })

		vim.keymap.set("x", "<C-space>", function()
			local node = get_node_at_cursor()
			if not node then
				return
			end
			local parent = node:parent()
			if not parent then
				return
			end
			local sr, sc, er, ec = parent:range()
			vim.cmd("normal! \27") -- exit visual to reset
			vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
			vim.cmd("normal! v")
			vim.api.nvim_win_set_cursor(0, { er + 1, ec > 0 and ec - 1 or 0 })
		end, { desc = "Increment treesitter selection" })

		vim.keymap.set("x", "<bs>", function()
			local node = get_node_at_cursor()
			if not node then
				return
			end
			-- Find the smallest child that covers the cursor position
			local cursor = vim.api.nvim_win_get_cursor(0)
			local row, col = cursor[1] - 1, cursor[2]
			local child = node:named_descendant_for_range(row, col, row, col)
			if child and child ~= node then
				local sr, sc, er, ec = child:range()
				vim.cmd("normal! \27")
				vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
				vim.cmd("normal! v")
				vim.api.nvim_win_set_cursor(0, { er + 1, ec > 0 and ec - 1 or 0 })
			end
		end, { desc = "Decrement treesitter selection" })
	end,
}
