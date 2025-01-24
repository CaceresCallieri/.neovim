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

-- Copy all file's contens to system clipboard
keymap.set("n", "<leader>my", 'gg"+yG', { desc = "Copy file contents to system  clipboard" })

-- Console.log Macros
-- Yank selected and console log it a line below
local consoleLogMacro = 'yoconsole.log("<esc>pa: ", <esc>pa)<esc>'

keymap.set("v", "<leader>mc", consoleLogMacro, { desc = "console.log selected variable" })

keymap.set("n", "<leader>mc", "_wviw" .. consoleLogMacro, { desc = "console.log variable from current line" })

-- Obsidian macros
keymap.set("n", "<leader>o", "", { desc = "Obsidian macros" })

keymap.set("n", "<leader>ot", "G{O- [ ] ", { desc = "Create todo" })

keymap.set("n", "<leader>oc", "0ci[x<esc>", { desc = "Check todo box" })

keymap.set("n", "<leader>oC", "0ci[x<esc>ddmaG{p'a", { desc = "Check todo box and move the line to the checked list" })

keymap.set("i", "<A-t>", "- [ ] ", { desc = "Create todo inline from insert mode" })
