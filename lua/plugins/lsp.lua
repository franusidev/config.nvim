return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		config = function()
			vim.lsp.enable('lua_ls')
			vim.lsp.enable('gopls')
			vim.lsp.enable('yamlls')
			vim.system({ "mise", "where", "github:PowerShell/PowerShellEditorServices" }, { text = true }, function(obj)
				vim.lsp.enable('powershell_es')
				local path = obj.stdout and obj.stdout:gsub("%s+$", "")
				vim.lsp.config('powershell_es', {
					bundle_path = path
				})
			end)
			vim.lsp.enable('bash_ls')
			-- this happens when an lsp is attached to a buffer
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('my.lsp', {}),
				-- this callback contains data of the buffer
				callback = function(ev)
					local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

					if not client then return end

					-- if the lsp allows formatting
					if not client:supports_method('textDocument/willSaveWaitUntil')
						and client:supports_method('textDocument/formatting') then
						-- create an autocmd on the buffer that runs on saving
						vim.api.nvim_create_autocmd('BufWritePre', {
							group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
							buffer = ev.buf,
							callback = function()
								-- format the buffer of the callback
								vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
							end,
						})
					end
				end,
			})
		end,
	},
}
