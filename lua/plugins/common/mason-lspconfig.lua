-- Neovim標準補完のLSP対応設定
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
            local mason_lspconfig = require("mason-lspconfig")
            mason_lspconfig.setup()

            -- Neovim標準補完のLSP対応設定
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true

            -- setup_handlersが存在する���チェック
            if mason_lspconfig.setup_handlers then
                mason_lspconfig.setup_handlers {
                    -- デフォルトハンドラ
                    function (server_name)
                        require("lspconfig")[server_name].setup {
                            on_attach = _G.on_attach, -- グローバルなon_attachを使用
                            capabilities = capabilities
                        }
                    end,
                }
            else
                -- フォールバック: 手動でLSPサーバーをセットアップ
                local servers = mason_lspconfig.get_installed_servers()
                for _, server_name in ipairs(servers) do
                    require("lspconfig")[server_name].setup {
                        on_attach = _G.on_attach, -- グローバルなon_attachを使用
                        capabilities = capabilities
                    }
                end
            end

            -- 標準補完の設定
            vim.o.completeopt = "menu,menuone,noselect"

            -- 診断設定
            vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
            )
        end
    }
}