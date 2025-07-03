-- VSCode WhichKey設定自動生成スクリプト
-- Neovimのキーマップ設定からVSCode WhichKey設定を自動生成

local M = {}

-- キーマップ定義（VSCode用コマンドとの対応）
local keymap_definitions = {
  -- 📁 ファイル検索
  f = {
    name = "📁 ファイル検索",
    bindings = {
      f = { name = "ファイル検索", command = "workbench.action.quickOpen" },
      g = { name = "文字列検索", command = "workbench.action.findInFiles" },
      r = { name = "最近のファイル", command = "workbench.action.openRecent" },
      b = { name = "バッファ検索", command = "workbench.action.showAllEditors" },
      c = { name = "コマンド検索", command = "workbench.action.showCommands" },
    }
  },
  -- 🎯 LSP操作
  l = {
    name = "🎯 LSP操作",
    bindings = {
      d = { name = "定義移動", command = "editor.action.revealDefinition" },
      r = { name = "参照検索", command = "editor.action.goToReferences" },
      h = { name = "ホバー", command = "editor.action.showHover" },
      a = { name = "コードアクション", command = "editor.action.quickFix" },
      n = { name = "リネーム", command = "editor.action.rename" },
      F = { name = "フォーマット", command = "editor.action.formatDocument" },
      o = { name = "アウトライン", command = "workbench.action.gotoSymbol" },
    }
  },
  -- 🔀 Git操作
  g = {
    name = "🔀 Git操作",
    bindings = {
      c = { name = "コミット履歴", command = "gitlens.showCommitsView" },
      b = { name = "ブランチ切り替え", command = "git.checkout" },
      s = { name = "Git状態", command = "workbench.view.scm" },
    }
  },
  -- 🤖 AI操作
  a = {
    name = "🤖 AI操作",
    bindings = {
      c = { name = "Claude Code起動", command = "claude-code.start" },
      p = { name = "ペースト", command = "claude-code.paste" },
      t = { name = "トグル", command = "claude-code.toggle" },
    }
  },
  -- 👁️ 表示/UI
  v = {
    name = "👁️ 表示/UI",
    bindings = {
      o = { name = "アウトライン表示", command = "outline.focus" },
    }
  },
  -- ✏️ コード操作
  c = {
    name = "✏️ コード操作",
    bindings = {
      j = { name = "行結合", command = "editor.action.joinLines" },
    }
  },
  -- 📋 バッファ操作
  b = {
    name = "📋 バッファ操作",
    bindings = {
      n = { name = "次のバッファ", command = "workbench.action.nextEditor" },
      p = { name = "前のバッファ", command = "workbench.action.previousEditor" },
      c = { name = "バッファを閉じる", command = "workbench.action.closeActiveEditor" },
    }
  },
  -- ⚙️ 設定
  i = {
    name = "⚙️ 設定",
    bindings = {
      c = { name = "設定開く", command = "workbench.action.openSettings" },
    }
  },
  -- 🚨 診断
  x = {
    name = "🚨 診断",
    bindings = {
      x = { name = "問題一覧", command = "workbench.actions.view.problems" },
      n = { name = "次の問題", command = "editor.action.marker.next" },
      p = { name = "前の問題", command = "editor.action.marker.prev" },
    }
  },
}

-- VSCode WhichKey設定のJSONを生成
function M.generate_vscode_whichkey_config()
  local function convert_bindings(bindings)
    local result = {}
    for key, value in pairs(bindings) do
      if value.command then
        -- 単一コマンド
        table.insert(result, {
          key = key,
          name = value.name,
          type = "command",
          command = value.command
        })
      elseif value.bindings then
        -- ネストしたバインディング
        table.insert(result, {
          key = key,
          name = value.name,
          type = "bindings",
          bindings = convert_bindings(value.bindings)
        })
      end
    end
    return result
  end

  local config = {
    ["whichkey.bindings"] = {
      {
        key = ";",  -- リーダーキー
        name = "Leader Commands",
        type = "bindings",
        bindings = convert_bindings(keymap_definitions)
      }
    },
    ["whichkey.delay"] = 500,
    ["whichkey.sortOrder"] = "alphabetically"
  }

  return config
end

-- VSCode設定ファイルのパスを取得
function M.get_vscode_settings_path()
  local os_name = vim.loop.os_uname().sysname
  local home = os.getenv("HOME") or os.getenv("USERPROFILE")
  
  if os_name == "Windows_NT" then
    return home .. "/AppData/Roaming/Code/User/settings.json"
  elseif os_name == "Darwin" then
    return home .. "/Library/Application Support/Code/User/settings.json"
  else
    return home .. "/.config/Code/User/settings.json"
  end
end

-- JSONファイルを読み込み
function M.read_json_file(filepath)
  local file = io.open(filepath, "r")
  if not file then
    return {}
  end
  
  local content = file:read("*all")
  file:close()
  
  -- 簡易JSON解析（vim.fn.json_decode使用）
  local ok, data = pcall(vim.fn.json_decode, content)
  if ok then
    return data
  else
    return {}
  end
end

-- JSONファイルに書き込み
function M.write_json_file(filepath, data)
  local content = vim.fn.json_encode(data)
  -- JSON整形
  content = content:gsub(",", ",\n  "):gsub("{", "{\n  "):gsub("}", "\n}")
  
  local file = io.open(filepath, "w")
  if file then
    file:write(content)
    file:close()
    return true
  end
  return false
end

-- メイン関数：VSCode設定を更新
function M.sync_to_vscode()
  local vscode_config = M.generate_vscode_whichkey_config()
  local settings_path = M.get_vscode_settings_path()
  
  print("📄 VSCode設定パス: " .. settings_path)
  
  -- 既存の設定を読み込み
  local existing_settings = M.read_json_file(settings_path)
  
  -- WhichKey設定をマージ
  for key, value in pairs(vscode_config) do
    existing_settings[key] = value
  end
  
  -- 設定ファイルに書き込み
  if M.write_json_file(settings_path, existing_settings) then
    print("✅ VSCode WhichKey設定を更新しました")
    print("🔄 VSCodeを再起動してください")
  else
    print("❌ 設定ファイルの書き込みに失敗しました")
  end
end

-- コマンドを登録
vim.api.nvim_create_user_command('SyncVSCodeWhichKey', function()
  M.sync_to_vscode()
end, { desc = "VSCode WhichKey設定を同期" })

return M