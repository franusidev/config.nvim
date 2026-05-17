return {
	{
		'akinsho/toggleterm.nvim',
		version = "*",
		opts = {},
		config = function()
			require("toggleterm").setup()
			vim.keymap.set("n", "<leader>tt", vim.cmd.ToggleTerm, { desc = "toggle the terminal" })
		end
	}
}
