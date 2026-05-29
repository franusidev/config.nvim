return {
	{
		'nvim-telescope/telescope.nvim',
		version = '*',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		},
		config = function()
			local builtin = require('telescope.builtin')

			require('telescope').setup {
				extensions = {
					fzf = {}
				}
			}

			require('telescope').load_extension('fzf')

			-- help
			vim.keymap.set("n", "<leader>fh",
				builtin.help_tags,
				{ desc = "find nvim help" }
			)
			-- files
			vim.keymap.set("n", "<leader>ff",
				builtin.find_files,
				{ desc = "find workspace files" }
			)
			vim.keymap.set("n", "<leader>fc",
				function()
					builtin.find_files {
						cwd = vim.fn.stdpath("config")
					}
				end,
				{ desc = "find nvim config files" }
			)
			-- buffers
			vim.keymap.set("n", "<leader>fb", function()
				builtin.buffers({
					sort_lastused = true,
					ignore_current_buffer = true,
					show_all_buffers = false,
				})
			end, { desc = "find open buffers" })
			-- find live grep
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "find in current files" })
			vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "find recent files" })
			vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "resume last telescope picker" })
			vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "find keymaps" })
			vim.keymap.set("n", "<leader>fs", builtin.current_buffer_fuzzy_find, { desc = "find in current buffer" })
			vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "find word under cursor" })
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "find diagnostics" })
			vim.keymap.set("n", "<leader>f/", function()
				builtin.live_grep({ grep_open_files = true, prompt_title = "Live Grep in Open Buffers" })
			end, { desc = "find in open buffers" })
		end
	}
}
