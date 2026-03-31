vim.g.mapleader = " "
local keymap = vim.keymap

----------------------------------------------------
-- Macros ------------------------------------------

-- Replace visually selected text macro
keymap.set(
	"v",
	"<leader>r", -- Replace
	"",
	{ noremap = true, silent = false, desc = "Replace Macros" }
)

keymap.set(
	"v",
	"<leader>rr", -- Replace replace
	'"hy:%s/<C-r>h/',
	{ noremap = true, silent = false, desc = "Replace currently selected text" }
)

keymap.set(
	"v",
	"<leader>ra", -- Replace add
	'"hy:%s/<C-r>h/<C-r>h',
	{ noremap = true, silent = false, desc = "Add to currently selected text" }
)

-- Clipboard macros
keymap.set("n", "<leader>my", '"+yy', { desc = "Copy current line contents to system  clipboard" })
keymap.set("v", "<leader>my", '"+yy', { desc = "Copy visually selected text to system  clipboard" })
keymap.set("n", "<leader>mY", 'gg"+yG', { desc = "Copy file contents to system  clipboard" })

-- Console.log Macros
-- Yank selected and console log it a line below
local consoleLogMacro = 'yoconsole.log("<esc>pa: ", <esc>pa)<esc>'

keymap.set("v", "<leader>mc", consoleLogMacro, { desc = "console.log selected variable" })

keymap.set("n", "<leader>mc", "_wviw" .. consoleLogMacro, { desc = "console.log variable from current line" })

-- Copy path macros
keymap.set("n", "<leader>c", "", { desc = "Copy path" })

keymap.set("n", "<leader>cc", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	vim.notify("Copied: " .. path)
end, { desc = "Copy absolute file path to clipboard" })

-- Obsidian macros
keymap.set("n", "<leader>o", "", { desc = "Obsidian macros" })

keymap.set("n", "<leader>ot", "G{O- [ ] ", { desc = "Create todo" })

keymap.set("n", "<leader>oc", "0ci[x<esc>", { desc = "Check todo box" })

keymap.set("n", "<leader>oC", "0ci[x<esc>ddmaG{p'a", { desc = "Check todo box and move the line to the checked list" })

keymap.set("i", "<A-t>", "- [ ] ", { desc = "Create todo inline from insert mode" })

-- Annotation macros (for design doc [JC] and [DISCUSS] blockquotes)
-- [JC] annotations — source of truth
keymap.set("n", "<A-n>", 'o> **[JC]:** <esc>a', { desc = "Insert [JC] annotation below" })
keymap.set("i", "<A-n>", "> **[JC]:** ", { desc = "Insert [JC] annotation inline" })
keymap.set("v", "<A-n>", "c> **[JC]:** <esc>pa", { desc = "Wrap selection in [JC] annotation" })

-- [DISCUSS] annotations — open discussion topics
keymap.set("n", "<A-N>", 'o> **[DISCUSS]:** <esc>a', { desc = "Insert [DISCUSS] annotation below" })
keymap.set("i", "<A-N>", "> **[DISCUSS]:** ", { desc = "Insert [DISCUSS] annotation inline" })
keymap.set("v", "<A-N>", "c> **[DISCUSS]:** <esc>pa", { desc = "Wrap selection in [DISCUSS] annotation" })

-- Leader-key aliases for which-key discoverability
keymap.set("n", "<leader>oa", 'o> **[JC]:** <esc>a', { desc = "Insert [JC] annotation" })
keymap.set("n", "<leader>od", 'o> **[DISCUSS]:** <esc>a', { desc = "Insert [DISCUSS] annotation" })
