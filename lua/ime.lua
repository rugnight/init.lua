-- === IME制御（Windows用 im-select） ===

local im_select_path = os.getenv("USERPROFILE") .. "\\.local\\bin\\im-select.exe"
local im_select_url = "https://github.com/daipeihust/im-select"

-- im-select を実行する関数
local function exec_im_select(cmd)
  if vim.fn.executable(im_select_path) == 1 then
    os.execute(im_select_path .. " " .. cmd)
  else
    vim.schedule(function()
      -- ユーザーに警告＋Yes/No を促す
      vim.ui.select({ "はい（開く）", "いいえ" }, {
        prompt = "⚠️ im-select.exe が見つかりません。ダウンロードページを開きますか？",
        kind = "user",
      }, function(choice)
        if choice == "はい（開く）" then
          -- Windowsでブラウザを開く
          os.execute('start "" "' .. im_select_url .. '"')
        end
      end)
    end)
  end
end

-- ノーマルモードで IME OFF
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    exec_im_select("1033")
  end
})

-- 挿入モードで IME ON（お好みで）
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    exec_im_select("1041")
  end
})

-- 起動時に存在チェック（任意）
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.executable(im_select_path) == 0 then
      vim.schedule(function()
        vim.ui.select({ "はい（開く）", "いいえ" }, {
          prompt = "⚠️ im-select.exe が見つかりません。ダウンロードページを開きますか？",
          kind = "user",
        }, function(choice)
          if choice == "はい（開く）" then
            os.execute('start "" "' .. im_select_url .. '"')
          end
        end)
      end)
    end
  end
})
