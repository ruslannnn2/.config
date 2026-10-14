local builtin = require('telescope.builtin')
local map = vim.keymap.set


--Telescope stuff
map('n', '<leader>ff', builtin.find_files, {})
map('n', '<leader>fg', builtin.git_files, {})
map('n', '<leader>ct', function()
  builtin.colorscheme({
    enable_preview = true
  })
end)

--Neotree bindings
map('n','<leader>nt' ,'<Cmd>Neotree toggle<CR>')

 --Window management
map("n", "<leader>wh", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<leader>wj", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<leader>wk", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<leader>wl", "<C-w>l", { desc = "Go to Right Window", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })
map("n", "<leader>wv", "<C-W>v", { desc = "Split Window Right", remap = true })

--Swap between buffers fast af
map("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })
