--set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- Commands --------------------------------------------
-- Rewrite :W as :w
vim.cmd("command! W w")

--------------------------------------------------------
-- General Keymaps -------------------------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- tab navigation
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })

keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<S-l>", ":tabnext<CR>", { noremap = true, silent = true, desc = "Go to next tab - Shortcut" })

keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set(
	"n",
	"<S-h>",
	":tabprev<CR>",
	{ noremap = true, silent = true, desc = "Navigate to previous tab - Shortcut" }
)

-- buffer navigation
keymap.set("n", "<leader>b", "", { desc = "Buffer navigation" })
keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Navigate to next buffer" })
keymap.set("n", "<leader>bp", ":bprev<CR>", { desc = "Navigate to previous buffer" })

-- Plugin general keymap, plugins keymaps are in their .lua file
keymap.set("n", "<leader>p", "", { desc = "Plugins keymaps" })

----------------------------------------------------
-- Macros ------------------------------------------

-- Obsidian macros
keymap.set("n", "<leader>o", "", { desc = "Obsidian macros" })

keymap.set("n", "<leader>ot", "G{O- [ ] ", { desc = "Create todo" })

keymap.set("n", "<leader>oc", "0ci[x<esc>ddmaG{p'a", { desc = "Check todo box and move the line to the checked list" })

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

-- console.log curent line variable
keymap.set(
	"n",
	"<leader>mc",
	'_wviwyoconsole.log("<esc>pa: ", <esc>pa)<esc>',
	{ desc = "console.log variable from current line" }
)
