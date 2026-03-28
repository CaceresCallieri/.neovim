return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
  keys = {
    { "<leader>xx", "<cmd>Trouble toggle diagnostics<CR>", desc = "Open/close trouble list" },
    { "<leader>xw", "<cmd>Trouble toggle diagnostics<CR>", desc = "Open trouble workspace diagnostics" },
    { "<leader>xd", "<cmd>Trouble toggle diagnostics buf=0<CR>", desc = "Open trouble document diagnostics" },
    { "<leader>xq", "<cmd>Trouble toggle quickfix<CR>", desc = "Open trouble quickfix list" },
    { "<leader>xl", "<cmd>Trouble toggle loclist<CR>", desc = "Open trouble location list" },
    { "<leader>xt", "<cmd>Trouble toggle todo<CR>", desc = "Open todos in trouble" },
    { "<leader>ft", "<cmd>Trouble toggle todo<CR>", desc = "Find todos" },
  },
}
