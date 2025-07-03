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
            
            -- LSP補完を有効化
            capabilities.textDocument.completion.completionItem.snippetSupport = true
            capabilities.textDocument.completion.completionItem.resolveSupport = {
                properties = {
                    "documentation",
                    "detail",
                    "additionalTextEdits",
                }
            }

            -- setup_handlersが存在するかチェック
            if mason_lspconfig.setup_handlers then
                mason_lspconfig.setup_handlers {
                    -- デフォルトハンドラ
                    function (server_name)
                        require("lspconfig")[server_name].setup {
                            capabilities = capabilities
                        }
                    end,
                }
            else
                -- フォールバック: 手動でLSPサーバーをセットアップ
                local servers = mason_lspconfig.get_installed_servers()
                for _, server_name in ipairs(servers) do
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end
            end

            -- 標準補完の設定
            vim.o.completeopt = "menu,menuone,noselect"
            
            -- 補完関連のキーマップ
            vim.keymap.set('i', '<C-n>', '<C-n>', { desc = "次の候補" })
            vim.keymap.set('i', '<C-p>', '<C-p>', { desc = "前の候補" })
            vim.keymap.set('i', '<C-Space>', '<C-x><C-o>', { desc = "LSP補完" })
            vim.keymap.set('i', '<C-f>', '<C-x><C-f>', { desc = "ファイル補完" })
            vim.keymap.set('i', '<C-l>', '<C-x><C-l>', { desc = "行補完" })
            
            -- 自動補完トリガーの設定
            local function setup_auto_completion()
                -- .入力時に自動でLSP補完を開始
                vim.keymap.set('i', '.', function()
                    vim.api.nvim_feedkeys('.', 'n', true)
                    vim.defer_fn(function()
                        if vim.fn.pumvisible() == 0 then
                            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-x><C-o>', true, false, true), 'n', true)
                        end
                    end, 100)
                end, { desc = "ドット補完" })
                
                -- 入力中の自動補完（2文字以上で開始）
                vim.api.nvim_create_autocmd({ "TextChangedI", "TextChangedP" }, {
                    callback = function()
                        local line = vim.api.nvim_get_current_line()
                        local col = vim.api.nvim_win_get_cursor(0)[2]
                        local before_cursor = line:sub(1, col)
                        
                        -- 2文字以上の単語を入力中かチェック
                        local word = before_cursor:match("%w+$")
                        if word and #word >= 2 and vim.fn.pumvisible() == 0 then
                            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-x><C-o>', true, false, true), 'n', true)
                        end
                    end
                })
                
                -- Tabキーで候補選択
                vim.keymap.set('i', '<Tab>', function()
                    if vim.fn.pumvisible() == 1 then
                        return vim.api.nvim_replace_termcodes('<C-n>', true, false, true)
                    else
                        return vim.api.nvim_replace_termcodes('<Tab>', true, false, true)
                    end
                end, { expr = true, desc = "Tab補完" })
                
                -- Shift+Tabで前の候補
                vim.keymap.set('i', '<S-Tab>', function()
                    if vim.fn.pumvisible() == 1 then
                        return vim.api.nvim_replace_termcodes('<C-p>', true, false, true)
                    else
                        return vim.api.nvim_replace_termcodes('<S-Tab>', true, false, true)
                    end
                end, { expr = true, desc = "Shift+Tab補完" })
                
                -- Enterで候補確定
                vim.keymap.set('i', '<CR>', function()
                    if vim.fn.pumvisible() == 1 then
                        return vim.api.nvim_replace_termcodes('<C-y>', true, false, true)
                    else
                        return vim.api.nvim_replace_termcodes('<CR>', true, false, true)
                    end
                end, { expr = true, desc = "Enter補完確定" })
            end
            
            -- LSPアタッチ時に自動補完を設定
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(ev)
                    setup_auto_completion()
                end,
            })
            
            -- 補完メニューの見た目改善
            vim.api.nvim_set_hl(0, 'Pmenu', { bg = '#3c3836', fg = '#ebdbb2' })
            vim.api.nvim_set_hl(0, 'PmenuSel', { bg = '#458588', fg = '#ebdbb2' })
            vim.api.nvim_set_hl(0, 'PmenuSbar', { bg = '#665c54' })
            vim.api.nvim_set_hl(0, 'PmenuThumb', { bg = '#a89984' })

            -- 診断設定
            vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
            )
        end
    }
}