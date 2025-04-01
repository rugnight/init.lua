return {
	"j-hui/fidget.nvim",
	tag = "legacy", -- レガシータグを使用（オプション、最新バージョンを使用する場合は削除）
	event = "LspAttach",
	opts = {
		-- デフォルト設定のオーバーライド
		text = {
			spinner = "dots", -- アニメーション表示（"dots", "line", "jump", "moon"など）
			done = "✓",       -- 完了時のアイコン
			commenced = "Started", -- 開始メッセージ
			completed = "完了",   -- 完了メッセージ
		},
		align = {
			bottom = false,   -- 画面下部に表示するかどうか
			right = true,     -- 画面右側に表示するかどうか
		},
		timer = {
			spinner_rate = 125, -- スピナーのアニメーション速度（ms）
			fidget_decay = 2000, -- 通知の表示時間（ms）
			task_decay = 1000,   -- タスク終了後の表示時間（ms）
		},
		window = {
			relative = "win", -- 表示位置（"editor", "win"）
			blend = 0,        -- 背景の透明度（0-100）
			zindex = nil,     -- 重なり順序
			border = "none",  -- ボーダースタイル
		},
		fmt = {
			-- メッセージのフォーマット関数
			task = function(task_name, message, percentage)
				return string.format(
					"%s%s [%s]",
					task_name,
					message and " " .. message or "",
					percentage and percentage .. "%" or "進行中"
				)
			end,
		},
	},
}
