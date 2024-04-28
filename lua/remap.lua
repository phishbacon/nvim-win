vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", "<cmd>NvimTreeToggle<cr>", {desc = "Toggle File Tree"})
-- Move to window using <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", {desc = "Go to left window", remap = true})
vim.keymap.set("n", "<C-j>", "<C-w>j", {desc = "Go to lower window", remap = true})
vim.keymap.set("n", "<C-k>", "<C-w>k", {desc = "Go to upper window", remap = true})
vim.keymap.set("n", "<C-l>", "<C-w>l", {desc = "Go to right window", remap = true})
-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>th", "<cmd>bprev<cr>")
vim.keymap.set("n", "<leader>tl", "<cmd>bnext<cr>")
vim.keymap.set("n", "<leader>tq", function ()
   if (vim.bo.buftype == "terminal") then
        vim.cmd("bd!")
    else
        vim.cmd("bd")
   end
end)

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("n", "<leader>bs", "<cmd>belowright split term://zsh<cr>")
vim.keymap.set("n", "<leader>bs", function ()
    if (os.getenv("HOME")) then
        vim.cmd("belowright split term://zsh")
    else
        vim.cmd("belowright split term://powershell")
    end
end)

vim.keymap.set("n", "<space>e", function ()
    vim.diagnostic.open_float(0, {scope = "line"})
end)
