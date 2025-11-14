return {
	"luukvbaal/statuscol.nvim",
	config = function()
		local builtin = require("statuscol.builtin")
		require("statuscol").setup({
			relculright = true, -- Right-align relative line numbers
			segments = {
				-- Fold column
				{
					text = { "%C" },
					click = "v:lua.ScFa",
				},
				-- Sign column (git signs, diagnostics, etc.)
				{
					text = { "%s" },
					click = "v:lua.ScSa",
				},
				-- Line numbers with custom spacing
				{
					text = { builtin.lnumfunc, "    " },
					condition = { true, builtin.not_empty },
					click = "v:lua.ScLa",
				},
			},
		})
	end,
}
