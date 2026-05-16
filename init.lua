require("config.lazy")

-- tabs transform to spaces and have 4 characters lenght
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
-- make the unnamed registry the system clipboard
vim.opt.clipboard = 'unnamedplus'

-- enable virtual text for diagnostics
vim.diagnostic.config({
	virtual_text = true
})

-- add a yank highlight
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking text',
	group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})
