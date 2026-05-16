return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
		config = function()
			require("which-key").add({
				{ "<leader>f", group = "files", icon = { icon = "", color = "yellow" } }, -- add group for files operations
				{ "<leader>b", group = "buffer", icon = { icon = "", color = "cyan" } }, -- add group for buffer operations
				{ "<leader>h", group = "help", icon = { icon = "󰋖", color = "grey" } }, -- add group for help operations
			})
		end
	}
}
