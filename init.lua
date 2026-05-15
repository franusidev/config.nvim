require("config.lazy")

-- tabs transform to spaces and have 4 characters lenght
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
-- make the unnamed registry the system clipboard
vim.opt.clipboard = 'unnamedplus'


vim.diagnostic.config({
	virtual_text = true
})

