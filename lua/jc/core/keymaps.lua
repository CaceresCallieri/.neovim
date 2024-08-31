--set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- Commands ---------------------

-- Rewrite :W as :w
vim.cmd("command! W w")
---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- make ñ useful
keymap.set("i", "C-d", "<backspace>", { desc = "Simple backspace" }) -- simple delete with ñ
-- keymap.set("i", "<C-ñ>", "<CR>", { desc = "Simple enter" }) -- FIX:

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
keymap.set("n", "<C-n>", "<cmd>tabn<CR>", { desc = "Go to next tab - Shortcut" })

keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<C-p>", "<cmd>tabp<CR>", { desc = "Navigate to previous tab - Shortcut" })

-- buffer navigation
keymap.set("n", "<leader>b", "", { desc = "Buffer navigation" })
keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Navigate to next buffer" })
keymap.set("n", "<leader>bp", ":bprev<CR>", { desc = "Navigate to previous buffer" })
