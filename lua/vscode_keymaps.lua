-- VSCode-Neovim専用キーマップ

-- VSCode環境でのみ実行
if not vim.g.vscode then
  return
end

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- VSCode APIを使用したコマンド実行関数
local function vscode_action(action)
  return function()
    vim.fn.VSCodeNotify(action)
  end
end

local function vscode_action_with_range(action)
  return function()
    vim.fn.VSCodeNotifyRange(action, vim.fn.line("."), vim.fn.line("."), 1)
  end
end

-- 基本移動（Neovim標準を維持）
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- リーダーキーベースの設定
local leader = vim.g.mapleader

-- 📁 ファイル操作（VSCodeネイティブ機能を使用）
keymap("n", leader .. "ff", vscode_action("workbench.action.quickOpen"), { desc = "📁 ファイル検索" })
keymap("n", leader .. "fg", vscode_action("workbench.action.findInFiles"), { desc = "📁 文字列検索" })
keymap("n", leader .. "fr", vscode_action("workbench.action.openRecent"), { desc = "📁 最近のファイル" })
keymap("n", leader .. "fb", vscode_action("workbench.action.showAllEditors"), { desc = "📁 バッファ検索" })
keymap("n", leader .. "fc", vscode_action("workbench.action.showCommands"), { desc = "📁 コマンド検索" })

-- 🎯 LSP操作（VSCodeのLSP機能を活用）
keymap("n", leader .. "ld", vscode_action("editor.action.revealDefinition"), { desc = "🎯 定義移動" })
keymap("n", leader .. "lr", vscode_action("editor.action.goToReferences"), { desc = "🎯 参照検索" })
keymap("n", leader .. "lh", vscode_action("editor.action.showHover"), { desc = "🎯 ホバー" })
keymap("n", "K", vscode_action("editor.action.showHover"), { desc = "🎯 ホバー情報" })
keymap("n", leader .. "la", vscode_action("editor.action.quickFix"), { desc = "🎯 コードアクション" })
keymap("n", leader .. "ln", vscode_action("editor.action.rename"), { desc = "🎯 リネーム" })
keymap("n", leader .. "lF", vscode_action("editor.action.formatDocument"), { desc = "🎯 ドキュメントフォーマット" })
keymap("v", leader .. "lF", vscode_action("editor.action.formatSelection"), { desc = "🎯 選択範囲フォーマット" })
keymap("n", leader .. "lo", vscode_action("workbench.action.gotoSymbol"), { desc = "🎯 アウトライン" })

-- 🔀 Git操作
keymap("n", leader .. "gc", vscode_action("gitlens.showCommitsView"), { desc = "🔀 コミット履歴" })
keymap("n", leader .. "gb", vscode_action("git.checkout"), { desc = "🔀 ブランチ切り替え" })
keymap("n", leader .. "gs", vscode_action("workbench.view.scm"), { desc = "🔀 Git状態" })

-- 🤖 AI操作（Claude Code統合）
keymap("n", leader .. "ac", vscode_action("claude-code.start"), { desc = "🤖 Claude Code起動" })
keymap("n", leader .. "ap", vscode_action("claude-code.paste"), { desc = "🤖 ペースト" })
keymap("n", leader .. "at", vscode_action("claude-code.toggle"), { desc = "🤖 トグル" })

-- 👁️ 表示/UI
keymap("n", leader .. "vo", vscode_action("outline.focus"), { desc = "👁️ アウトライン表示" })
keymap("n", leader .. "o", vscode_action("outline.focus"), { desc = "👁️ アウトライン表示" })

-- ✏️ コード操作
keymap("n", leader .. "cj", "J", { desc = "✏️ 行結合" })
keymap("n", leader .. "cs", "i<CR><Esc>", { desc = "✏️ 行分割" })

-- 📋 バッファ操作
keymap("n", leader .. "bn", vscode_action("workbench.action.nextEditor"), { desc = "📋 次のバッファ" })
keymap("n", leader .. "bp", vscode_action("workbench.action.previousEditor"), { desc = "📋 前のバッファ" })
keymap("n", leader .. "bc", vscode_action("workbench.action.closeActiveEditor"), { desc = "📋 バッファを閉じる" })

-- ⚙️ 設定
keymap("n", leader .. "ic", vscode_action("workbench.action.openSettings"), { desc = "⚙️ 設定開く" })

-- 🚨 診断
keymap("n", leader .. "xx", vscode_action("workbench.actions.view.problems"), { desc = "🚨 問題一覧" })
keymap("n", leader .. "xn", vscode_action("editor.action.marker.next"), { desc = "🚨 次の問題" })
keymap("n", leader .. "xp", vscode_action("editor.action.marker.prev"), { desc = "🚨 前の問題" })

-- ウィンドウ移動（VSCode用）
keymap("n", "<C-h>", vscode_action("workbench.action.focusLeftGroup"), opts)
keymap("n", "<C-j>", vscode_action("workbench.action.focusBelowGroup"), opts)
keymap("n", "<C-k>", vscode_action("workbench.action.focusAboveGroup"), opts)
keymap("n", "<C-l>", vscode_action("workbench.action.focusRightGroup"), opts)

-- 検索のハイライトを消去
keymap("n", "<Esc>", ":nohl<CR>", opts)

-- コメントアウト（VSCode機能を使用）
keymap("n", "gcc", vscode_action("editor.action.commentLine"), { desc = "行コメント切り替え" })
keymap("v", "gc", vscode_action("editor.action.commentLine"), { desc = "選択範囲コメント切り替え" })