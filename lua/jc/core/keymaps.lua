--set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- Commands --------------------------------------------
-- Rewrite :"X" as :"x"
vim.cmd("command! W w")
vim.cmd("command! Q q")

--------------------------------------------------------
-- General Keymaps -------------------------------------

-- Keymap to toggle virtual_lines on/off
local virtual_text_config = vim.diagnostic.config().virtual_text

keymap.set("n", "<A-d>", function()
	if vim.diagnostic.config().virtual_lines then
		vim.diagnostic.config({
			virtual_lines = false,
			virtual_text = virtual_text_config,
		})
	else
		vim.diagnostic.config({
			virtual_lines = true,
			virtual_text = false,
		})
	end
end, { desc = "Toggle virtual_lines for diagnostics" })

-- save shortcut
keymap.set("n", "<M-w>", "<cmd>w<CR>", { desc = "Save file" })

-- clear search highlights
keymap.set("n", "<leader>nh", "<cmd>nohl<CR>", { desc = "Clear search highlights" })

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

-- tabs navigation
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })

keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })

-- Shortcut tab navigation
keymap.set(
	{ "n", "i" },
	"<S-C-l>",
	"<cmd>tabnext<CR>",
	{ noremap = true, silent = true, desc = "Go to next tab - Shortcut" }
)
keymap.set(
	{ "n", "i" },
	"<S-C-h>",
	"<cmd>tabprev<CR>",
	{ noremap = true, silent = true, desc = "Navigate to previous tab - Shortcut" }
)
keymap.set(
	{ "n", "i" },
	"<S-C-t>",
	"<cmd>tabnew<CR>",
	{ noremap = true, silent = true, desc = "Open new tab - Shortcut" }
)

-- buffer navigation
keymap.set("n", "<leader>b", "", { desc = "Buffer navigation" })
keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Navigate to next buffer in buffer list" })
keymap.set("n", "<leader>bp", "<cmd>bprev<CR>", { desc = "Navigate to previous buffer in buffer list" })
keymap.set("n", "<M-b>", "<C-6>", { noremap = true, silent = true, desc = "Navigate to last visited buffer" })

-- terminal navigation
keymap.set("n", "<C-CR>", "<cmd>terminal<CR>i", { desc = "Open terminal buffer" }) -- Open terminal "buffer" and insert into Terminal mode
keymap.set("t", "<C-x>", [[<C-\><C-n>]], { noremap = true, silent = true }) -- Escape terminal mode

-- Plugin general keymap, plugins keymaps are in their respective .lua file
keymap.set("n", "<leader>p", "", { desc = "Plugins keymaps" })
keymap.set("n", "<leader>pc", "", { desc = "Color related plugins keymaps" })
keymap.set("n", "<leader>e", "", { desc = "File explorers" })
