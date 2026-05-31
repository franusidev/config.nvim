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
				{ "<leader>f", group = "telescope", icon = { icon = "", color = "yellow" } },
				{ "<leader>b", group = "buffer", icon = { icon = "", color = "cyan" } },
				{ "<leader>d", group = "debug", icon = { icon = "", color = "orange" } },
				{ "<leader>t", group = "test", icon = { icon = "", color = "green" } },
				{ "<leader>%", group = "other", icon = { icon = "󰾴", color = "purple" } },
			})
		end
	}
}
