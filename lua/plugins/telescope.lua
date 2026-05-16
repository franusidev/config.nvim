return {
	{
		'nvim-telescope/telescope.nvim',
		version = '*',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		},
		config = function()
			require('telescope').setup {
				extensions = {
					fzf = {}
				}
			}

			require('telescope').load_extension('fzf')

			-- help
			vim.keymap.set("n", "<leader>hf",
				require('telescope.builtin').help_tags,
				{ desc = "find nvim help" }
			)
			-- files
			vim.keymap.set("n", "<leader>ff",
				require('telescope.builtin').find_files,
				{ desc = "find workspace files" }
			)
			vim.keymap.set("n", "<leader>fc",
				function()
					require('telescope.builtin').find_files {
						cwd = vim.fn.stdpath("config")
					}
				end,
				{ desc = "find nvim config files" }
			)
			-- buffers
			vim.keymap.set("n", "<leader>bf", function()
				require('telescope.builtin').buffers({
					sort_lastused = true,
					ignore_current_buffer = true,
					show_all_buffers = false,
				})
			end, { desc = "find open buffers" })
			require "config.telescope.multigrep".setup()
		end
	}
}
