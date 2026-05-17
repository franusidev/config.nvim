return {
	{
		'stevearc/oil.nvim',
		dependencies = { { "nvim-mini/mini.icons", opts = {} } },
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
		config = function()
			require("oil").setup({
				skip_confirm_for_simple_edits = true,
				view_options = {
					show_hidden = true
				},
			})
			vim.keymap.set("n", "-", function()
				require("oil").open(vim.fn.getcwd())
			end, { desc = "explore files in workspace" })
			vim.keymap.set("n", "_", function()
				require("oil").open(vim.fn.expand("%:p:h"))
			end, { desc = "explore files in current directory" })
			vim.api.nvim_create_autocmd("User", {
				pattern = "OilEnter",
				callback = vim.schedule_wrap(function(args)
					local oil = require("oil")
					if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
						oil.open_preview()
					end
				end),
			})
		end
	}
}
