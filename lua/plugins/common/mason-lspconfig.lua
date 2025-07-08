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

            -- LSPサーバーの基本設定
            local function on_attach(client, bufnr)
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
            end

            -- setup_handlersが存在するかチェック
            if mason_lspconfig.setup_handlers then
                mason_lspconfig.setup_handlers {
                    -- デフォルトハンドラ
                    function (server_name)
                        require("lspconfig")[server_name].setup {
                            on_attach = on_attach,
                            capabilities = capabilities
                        }
                    end,
                }
            else
                -- フォールバック: 手動でLSPサーバーをセットアップ
                local servers = mason_lspconfig.get_installed_servers()
                for _, server_name in ipairs(servers) do
                    require("lspconfig")[server_name].setup {
                        on_attach = on_attach,
                        capabilities = capabilities
                    }
                end
            end

            -- 標準補完の設定（シンプル版）
            vim.o.completeopt = "menu,menuone,noselect"
            
            -- 入力中の自動補完（シンプル版）
            vim.api.nvim_create_autocmd("TextChangedI", {
                pattern = "*",
                callback = function()
                    local line = vim.api.nvim_get_current_line()
                    local col = vim.api.nvim_win_get_cursor(0)[2]
                    local word_before = line:sub(1, col):match("[%w_]*$")
                    
                    -- 3文字以上の英数字入力時に自動補完を起動
                    if word_before and #word_before >= 3 and vim.fn.pumvisible() == 0 then
                        vim.defer_fn(function()
                            if vim.fn.mode() == "i" then
                                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-x><C-o>', true, false, true), 'n', false)
                            end
                        end, 150)
                    end
                end,
            })

            -- 診断設定は lsp-config.lua で設定済みのため削除
        end
    }
}