require("config.lazy")

-- tabs transform to spaces and have 4 characters lenght
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
-- make the unnamed registry the system clipboard
vim.opt.clipboard = 'unnamedplus'
vim.opt.splitright = true

vim.o.winborder = "rounded"

vim.o.relativenumber = true
vim.o.number = true

-- add a yank highlight
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking text',
	group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

local map = vim.keymap.set



-- =========================lsp.foldexpr()"
-- =========================
-- Window management
-- =========================
map("n", "<leader>q", "<cmd>quit<CR>", { silent = true, desc = "quit current window" })
map("n", "<leader>Q", "<cmd>quit!<CR>", { silent = true, desc = "force quit current window" })

-- =========================
-- File / Buffer Management
-- =========================

map("n", "<leader>bw", "<cmd>write<CR>", { silent = true, desc = "write buffer" })

map("n", "<leader>bn", "<cmd>enew<CR>", { silent = true, desc = "new empty buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { silent = true, desc = "delete buffer" })

map("n", "<Tab>", "<cmd>bnext<CR>", { silent = true })
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { silent = true })

-- =========================
-- Window Navigation
-- =========================

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- =========================
-- Resize Splits
-- =========================

map("n", "<C-Up>", "<cmd>resize +2<CR>")
map("n", "<C-Down>", "<cmd>resize -2<CR>")
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>")
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>")

-- =========================
-- Terminal Escape
-- =========================

map("t", "<Esc>", [[<C-\><C-n>]])
