-- ~/.config/nvim/init.lua

--------------------------------------------------
-- Leader keys
--------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = "//"

--------------------------------------------------
-- Diagnostics
--------------------------------------------------
vim.diagnostic.config({
  virtual_text = true,  -- show inline messages
  signs = true,         -- show signs in the gutter
  underline = true,     -- underline problematic text
  update_in_insert = false, -- don't update diagnostics while typing
  severity_sort = true,     -- sort diagnostics by severity
})
--------------------------------------------------
-- Editor options
--------------------------------------------------

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Tabs & indentation
-- Go uses real tabs by convention
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false

-- Visual improvements
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"

-- Clipboard
vim.opt.clipboard = "unnamedplus"

--------------------------------------------------
-- Diagnostics keymaps
--------------------------------------------------
vim.keymap.set(
    "n",
    "<leader>q",
    vim.diagnostic.setloclist,
    { desc = "Open diagnostic list" }
)

vim.keymap.set(
    "n",
    "<leader>e",
    vim.diagnostic.open_float,
    { desc = "Open floating diagnostic message" }
)

--------------------------------------------------
-- Install lazy.nvim
--------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

--------------------------------------------------
-- Plugins
--------------------------------------------------
require("lazy").setup({

    --------------------------------------------------
    -- Theme
    --------------------------------------------------
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
				config = function()
					vim.cmd.colorscheme("catppuccin-nvim")
				end
    },

    --------------------------------------------------
    -- Mason
    --------------------------------------------------
    {
        "williamboman/mason.nvim",
        config = true,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        config = true,
    },

    --------------------------------------------------
    -- LSP
    --------------------------------------------------
    {
        "neovim/nvim-lspconfig",

        config = function()

            --------------------------------------------------
            -- Lua LSP
            --------------------------------------------------
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },

                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },

                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })

            vim.lsp.enable("lua_ls")

            --------------------------------------------------
            -- Go LSP
            --------------------------------------------------
            vim.lsp.config("gopls", {})

            vim.lsp.enable("gopls")

            --------------------------------------------------
            -- LSP keymaps
            --------------------------------------------------
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(ev)
                    local opts = { buffer = ev.buf }

                    -- Go to definition
                    vim.keymap.set(
                        "n",
                        "gd",
                        vim.lsp.buf.definition,
                        opts
                    )

                    -- Hover documentation
                    vim.keymap.set(
                        "n",
                        "K",
                        vim.lsp.buf.hover,
                        opts
                    )

                    -- Rename symbol
                    vim.keymap.set(
                        "n",
                        "<leader>rn",
                        vim.lsp.buf.rename,
                        opts
                    )

										vim.keymap.set(
                        "n",
                        "<leader>df",
                        vim.lsp.buf.format,
												{ desc = "format current buffer using lsp" }
                    )
                end,
            })
        end,
    },

    --------------------------------------------------
    -- Treesitter
    --------------------------------------------------
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false,
        branch = "master",

        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "go",
                    "lua",
                    "vim",
                    "vimdoc",
                    "jsonc",
                },

                auto_install = false,

                highlight = {
                    enable = true,
                },
            })
        end,
    },
		{
			'saghen/blink.cmp',
			-- Nota: Requiere descargar un binario precompilado (lo hace solo)
			version = '1.*',
			opts = {
				-- Configuración de teclas (estilo estándar)
				keymap = { preset = 'default' },
				completion = {
					documentation = {
						auto_show = true,
						auto_show_delay_ms = 500,
					}
				},
				signature = {
					enabled = true
				},
				-- Fuentes de donde sacará el texto
				sources = {
					default = { 'lsp', 'path', 'snippets', 'buffer' },
				},

				-- Opcional: Mostrar iconos bonitos
				appearance = {
					use_nvim_cmp_as_default = true,
					nerd_font_variant = 'mono'
				},
			},
		},
    --------------------------------------------------
    -- Which-key
    --------------------------------------------------
    {
        "folke/which-key.nvim",
        event = "VeryLazy",

        opts = {},

        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
})
