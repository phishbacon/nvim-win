return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local util = require 'lspconfig.util'
        local port = os.getenv 'GDScript_Port' or '6008'
        local cmd = { 'ncat', 'localhost', port }


        local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "tsserver",
            },
            handlers = {
                function(server_name) -- default handler (optional)

                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
            }
        })
        require'lspconfig'.gdscript.setup{
            default_config = {
                cmd = cmd,
                filetypes = { 'gd', 'gdscript', 'gdscript3' },
                root_dir = util.root_pattern('project.godot'),
            },
            docs = {
                description = [[
                https://github.com/godotengine/godot

                Language server for GDScript, used by Godot Engine.
                ]],
                default_config = {
                    root_dir = [[util.root_pattern("project.godot")]],
                },
            },
        }
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local cmp_confirm = { behavior = cmp.ConfirmBehavior.Insert }

        cmp.setup({
            completion = {
                completeopt = 'menu,menuone,noinsert'
            },
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<cr>'] = cmp.mapping.confirm({ select = true, cmp_confirm }),
                ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-l>'] = cmp.mapping({
                    i = function ()
                        if cmp.visible() then
                            cmp.abort()
                        end
                    end,
                    c = function ()
                        if cmp.visible() then
                            cmp.close()
                        end
                    end,
                }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
