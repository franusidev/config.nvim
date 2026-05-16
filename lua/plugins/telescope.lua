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

			vim.keymap.set("n", "<leader>fh",
				require('telescope.builtin').help_tags,
				{ desc = "find help in nvim" }
			)
			vim.keymap.set("n", "<leader>ff",
				require('telescope.builtin').find_files,
				{ desc = "find files in workspace" }
			)
			vim.keymap.set("n", "<leader>fc",
				function()
					require('telescope.builtin').find_files {
						cwd = vim.fn.stdpath("config")
					}
				end,
				{ desc = "find files in nvim config" }
			)
			require "config.telescope.multigrep".setup()
		end
	}
}
