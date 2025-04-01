return {
    'renerocksai/telekasten.nvim',
    dependencies = {
        'nvim-telescope/telescope.nvim',
        'nvim-lua/plenary.nvim',  -- Telescopeの依存プラグイン
        'nvim-telescope/telescope-media-files.nvim'  -- 画像プレビュー用
    },
    config = function()
        require('telekasten').setup({
            -- メインの設定
            home = vim.fn.expand("~/.memo"),  -- メモを保存するディレクトリ
            take_over_my_home = true,  -- ホームディレクトリを完全に管理

            -- 日記関連の設定
            dailies = vim.fn.expand("~/.memo/journal"),  -- 日記を保存するディレクトリ
            weeklies = vim.fn.expand("~/.memo/weekly"),  -- 週報を保存するディレクトリ
            templates = vim.fn.expand("~/.memo/templates"),  -- テンプレートディレクトリ

            -- テンプレートファイル
            template_new_note = vim.fn.expand("~/.memo/templates/new_note.md"),  -- 新規ノート用テンプレート
            template_new_daily = vim.fn.expand("~/.memo/templates/daily.md"),  -- 日記用テンプレート
            template_new_weekly = vim.fn.expand("~/.memo/templates/weekly.md"),  -- 週報用テンプレート

            -- ファイル形式と命名規則
            extension = ".md",  -- ノートの拡張子
            new_note_filename = "title",  -- 新規ノートのファイル名（title: タイトルベース, uuid: UUIDベース）
            uuid_type = "%Y%m%d%H%M",  -- UUID形式（日時ベース）
            uuid_sep = "-",  -- UUIDの区切り文字
            filename_case = "lower",  -- ファイル名を小文字に変換（lower, upper, titleなど）

            -- 日記の日付形式
            journal_format = "%Y-%m-%d",  -- 日記のファイル名形式
            weekly_format = "%Y_w%V",  -- 週報のファイル名形式

            -- 画像と添付ファイル
            image_subdir = "img",  -- 画像保存用サブディレクトリ
            extension_image = "jpg,jpeg,png,gif",  -- 認識する画像拡張子
            context_aware_previews = true,  -- コンテキスト依存のプレビュー表示

            -- 検索と表示オプション
            subdirs_in_links = true,  -- リンク内にサブディレクトリを含める
            templates_subdir = "templates",  -- テンプレートのサブディレクトリ
            sort = "filename",  -- ソート方式（filename, modified, accessedなど）
            show_tags_in_statusline = true,  -- ステータスラインにタグを表示

            -- インサートモードオプション
            close_after_yanking = false,  -- リンクコピー後にウィンドウを閉じる
            insert_after_inserting = true,  -- リンク挿入後にインサートモードに戻る

            -- プレビューと表示設定
            vaults = {  -- 複数のナレッジベースを定義可能
                work = { home = vim.fn.expand("~/work_notes") },
                personal = { home = vim.fn.expand("~/personal_notes") }
            },
            auto_set_filetype = true,  -- ファイルタイプを自動設定
            link_style = "markdown",  -- リンクスタイル（wiki: [[Title]], markdown: [Title](file.md)）

            -- カレンダー設定
            calendar_opts = {
                weeknm = 4,  -- 週番号の表示位置
                calendar_monday = 1,  -- 月曜始まり
                calendar_mark = "left-fit",  -- マークの表示位置
            },

            -- ハイライトグループ
            highlight_groups = {
                -- カスタムハイライトグループを定義
                TeleskatenTags = { link = "@text.reference" },
                TeleskatenLinks = { link = "@text.reference" },
                TeleskatenHighlights = { link = "@text.literal" },
            },
        })

        -- キーマッピング：基本的な操作
        vim.keymap.set("n", "<leader>z", "<cmd>Telekasten panel<CR>", { desc = "Telekastenパネルを開く" })
        vim.keymap.set("n", "<leader>zf", "<cmd>Telekasten find_notes<CR>", { desc = "ノートを検索" })
        vim.keymap.set("n", "<leader>zg", "<cmd>Telekasten search_notes<CR>", { desc = "ノート内をGrep検索" })
        vim.keymap.set("n", "<leader>zd", "<cmd>Telekasten goto_today<CR>", { desc = "今日の日記へ移動" })
        vim.keymap.set("n", "<leader>zz", "<cmd>Telekasten follow_link<CR>", { desc = "リンクをたどる" })
        vim.keymap.set("n", "<leader>zn", "<cmd>Telekasten new_note<CR>", { desc = "新規ノート作成" })
        
        -- キーマッピング：カレンダーとバックリンク
        vim.keymap.set("n", "<leader>zc", "<cmd>Telekasten show_calendar<CR>", { desc = "カレンダーを表示" })
        vim.keymap.set("n", "<leader>zb", "<cmd>Telekasten show_backlinks<CR>", { desc = "バックリンクを表示" })
        vim.keymap.set("n", "<leader>zI", "<cmd>Telekasten insert_img_link<CR>", { desc = "画像リンクを挿入" })
        
        -- キーマッピング：リンク関連
        vim.keymap.set("i", "[[", "<cmd>Telekasten insert_link<CR>", { desc = "リンクを挿入" })
        vim.keymap.set("n", "<leader>z#", "<cmd>Telekasten show_tags<CR>", { desc = "タグ一覧を表示" })
        vim.keymap.set("n", "<leader>zy", "<cmd>Telekasten yank_notelink<CR>", { desc = "現在のノートへのリンクをコピー" })
        
        -- キーマッピング：週報と日記
        vim.keymap.set("n", "<leader>zw", "<cmd>Telekasten goto_thisweek<CR>", { desc = "今週の週報へ移動" })
        vim.keymap.set("n", "<leader>zW", "<cmd>Telekasten find_weekly_notes<CR>", { desc = "週報を検索" })
        vim.keymap.set("n", "<leader>zT", "<cmd>Telekasten find_daily_notes<CR>", { desc = "日記を検索" })
        
        -- キーマッピング：その他の機能
        vim.keymap.set("n", "<leader>zt", "<cmd>Telekasten toggle_todo<CR>", { desc = "TODOのステータスを切り替え" })
        vim.keymap.set("n", "<leader>zp", "<cmd>Telekasten preview_img<CR>", { desc = "画像をプレビュー" })
        vim.keymap.set("n", "<leader>zm", "<cmd>Telekasten browse_media<CR>", { desc = "メディアファイルを閲覧" })
    end
}
