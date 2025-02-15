local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>cw", builtin.spell_suggest, { desc = "Spell suggest" })
vim.keymap.set("n", "<cr>", "o")
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "Q", "<cmd>q<cr><esc>")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-a>", "GVgg")
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>rw", vim.lsp.buf.rename) -- smart rename
vim.keymap.set("n", "<leader>li", ":LspInfo<CR>") -- mapping to restart lsp if necessary
vim.keymap.set("n", "<leader>lr", ":LspRestart<CR>") -- mapping to restart lsp if necessary
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("n", "<leader>ra", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true }) -- make file executable
