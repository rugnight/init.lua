-- Neovim 0.11 新API対応LSP設定（Mason管理版）
return {
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
        opts = {},
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "williamboman/mason.nvim" },
            { "neovim/nvim-lspconfig" },
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",           -- Lua
                    "omnisharp",        -- C#
                    "marksman",         -- Markdown
                },
                automatic_installation = true,
            })

            -- Neovim 0.11の新しいLSP設定API
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true

            -- グローバル設定
            vim.lsp.config('*', {
                capabilities = capabilities,
                root_markers = { '.git', '.luarc.json', 'package.json', '*.sln', '*.csproj' },
                on_attach = function(client, bufnr)
                    -- omnifuncを設定
                    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
                    
                    -- 最小限のon_attach設定
                    local map = vim.keymap.set
                    local opts = { buffer = bufnr, silent = true }
                    
                    -- 標準補完のキーマップ
                    map('i', '<C-Space>', '<C-x><C-o>', vim.tbl_extend('force', opts, { desc = "LSP補完" }))
                    
                    -- ドット補完
                    map('i', '.', function()
                        vim.api.nvim_feedkeys('.', 'n', true)
                        vim.defer_fn(function()
                            if vim.fn.pumvisible() == 0 then
                                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-x><C-o>', true, false, true), 'n', true)
                            end
                        end, 100)
                    end, vim.tbl_extend('force', opts, { desc = "ドット補完" }))
                    
                    -- Tab統合補完（LuaSnipで統合設定済みのためコメントアウト）
                    -- map('i', '<Tab>', function()
                    --     if vim.fn.pumvisible() == 1 then
                    --         return '<C-n>'
                    --     else
                    --         return '<Tab>'
                    --     end
                    -- end, vim.tbl_extend('force', opts, { expr = true }))
                    
                    -- map('i', '<S-Tab>', function()
                    --     if vim.fn.pumvisible() == 1 then
                    --         return '<C-p>'
                    --     else
                    --         return '<S-Tab>'
                    --     end
                    -- end, vim.tbl_extend('force', opts, { expr = true }))
                    
                    -- Enter補完確定
                    map('i', '<CR>', function()
                        if vim.fn.pumvisible() == 1 then
                            return '<C-y>'
                        else
                            return '<CR>'
                        end
                    end, vim.tbl_extend('force', opts, { expr = true }))
                end,
            })

            -- Lua Language Server設定
            vim.lsp.config('lua_ls', {
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            globals = { 'vim' },
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

            -- C# OmniSharp設定
            vim.lsp.config('omnisharp', {
                filetypes = { 'cs' },
                root_markers = { '*.sln', '*.csproj', 'omnisharp.json' },
                settings = {
                    FormattingOptions = {
                        EnableEditorConfigSupport = true,
                        OrganizeImports = true,
                    },
                    MsBuild = {
                        LoadProjectsOnDemand = false,
                    },
                    RoslynExtensionsOptions = {
                        EnableAnalyzersSupport = true,
                        EnableImportCompletion = true,
                        AnalyzeOpenDocumentsOnly = false,
                    },
                },
            })

            -- Markdown Marksman設定
            vim.lsp.config('marksman', {
                filetypes = { 'markdown', 'md' },
                root_markers = { '.git', '.marksman.toml' },
                settings = {
                    marksman = {
                        completion = {
                            wiki = {
                                enabled = true,
                            },
                        },
                    },
                },
            })

            -- LSPサーバーを有効化
            vim.lsp.enable('lua_ls')
            vim.lsp.enable('omnisharp')
            vim.lsp.enable('marksman')

            -- 補完設定（Neovim 0.11新機能）
            vim.o.completeopt = "menu,menuone,noselect,fuzzy,preinsert"

            -- 診断設定
            vim.diagnostic.config({
                virtual_text = false,
                float = {
                    border = 'rounded',
                    source = 'always',
                },
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })
        end
    }
}