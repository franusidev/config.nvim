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
		},
		config = function()
			require("which-key").add({
				{ "<leader>f", group = "telescope", icon = { icon = "", color = "yellow" } }, -- add group for search operations
				{ "<leader>b", group = "buffer", icon = { icon = "", color = "cyan" } }, -- add group for buffer operations
				{ "<leader>d", group = "debug", icon = { icon = "", color = "orange" } }, -- add group for buffer operations
			})
		end
	}
}
