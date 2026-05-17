return {
	{
		'stevearc/oil.nvim',
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			view_options = {
				show_hidden = true
			},
		},
		-- Optional dependencies
		dependencies = { { "nvim-mini/mini.icons", opts = {} } },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
		config = function()
			require("oil").setup()
			vim.keymap.set("n", "-", function()
				require("oil").open(vim.fn.getcwd())
			end, { desc = "explore files in workspace" })
			vim.keymap.set("n", "_", function()
				require("oil").open(vim.fn.expand("%:p:h"))
			end, { desc = "explore files in current directory" })
		end
	}
}
