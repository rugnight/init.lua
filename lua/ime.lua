-- === Google日本語入力対応 IME切替 (Windows) ===

local im_select_path = os.getenv("USERPROFILE") .. "\\.local\\bin\\im-select.exe"
local im_select_url = "https://github.com/daipeihust/im-select"

-- 起動時に im-select の存在を確認
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

-- Google日本語入力用の IME制御（1033: IME OFF, 1041: IME ON）
local function set_ime(mode)
  if vim.fn.executable(im_select_path) == 1 then
    local lang = (mode == "off") and "1033" or "1041"
    os.execute(im_select_path .. " " .. lang)
  end
end

-- ノーマルモードに入ったら IME OFF
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    set_ime("off")
  end
})

-- 挿入モードに入ったら IME ON
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    set_ime("on")
  end
})
