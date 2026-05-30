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
			vim.lsp.config('yamlls', {
				kubernetes = "*.yaml",
				["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
				["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
				["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
				["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
				["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] =
				"*api*.{yml,yaml}",
				["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] =
				"*docker-compose*.{yml,yaml}",
				["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] =
				"*flow*.{yml,yaml}",
			})
			vim.system({ "mise", "where", "github:PowerShell/PowerShellEditorServices" }, { text = true },
				function(obj)
					if obj.code ~= 0 then
						return
					end

					local path = (obj.stdout or ""):gsub("%s+$", "")

					-- vim.lsp must always run in the main thread
					vim.schedule(function()
						vim.lsp.config('powershell_es', {
							bundle_path = path,
						})
						vim.lsp.enable('powershell_es')
					end)
				end
			)
			vim.lsp.enable('bash_ls')
			-- this happens when an lsp is attached to a buffer
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('my.lsp', {}),
				-- this callback contains data of the buffer
				callback = function(ev)
					local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

					if not client then return end

					local map = function(lhs, rhs, desc)
						vim.keymap.set('n', lhs, rhs, { buffer = ev.buf, desc = desc })
					end

					map('gd', vim.lsp.buf.definition, 'LSP definition')
					map('gr', vim.lsp.buf.references, 'LSP references')
					map('gI', vim.lsp.buf.implementation, 'LSP implementation')
					map('K', vim.lsp.buf.hover, 'LSP hover')
					map('<leader>lr', vim.lsp.buf.rename, 'LSP rename')
					map('<leader>la', vim.lsp.buf.code_action, 'LSP code action')
					map('<leader>lf', function()
						vim.lsp.buf.format({ bufnr = ev.buf, timeout_ms = 1000 })
					end, 'LSP format')
					map('<leader>ls', vim.lsp.buf.document_symbol, 'LSP document symbols')
					map('<leader>lS', vim.lsp.buf.workspace_symbol, 'LSP workspace symbols')

					map(']d', vim.diagnostic.goto_next, 'Next diagnostic')
					map('[d', vim.diagnostic.goto_prev, 'Previous diagnostic')
					map('<leader>le', vim.diagnostic.open_float, 'Line diagnostics')
					map('<leader>lq', vim.diagnostic.setqflist, 'Diagnostics quickfix')
					map('<leader>ll', vim.diagnostic.setloclist, 'Diagnostics loclist')
					map('<leader>ld', function()
						local vt = vim.diagnostic.config().virtual_text
						vim.diagnostic.config({ virtual_text = vt == false })
					end, 'Toggle diagnostic virtual text')

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
