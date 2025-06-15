return {
  'f-person/git-blame.nvim',
  config = function()
    vim.g.gitblame_enabled = 1
    vim.g.gitblame_message_template = '<author> • <date> • <summary>'
    vim.g.gitblame_date_format = '%Y/%m/%d %H:%M'
    vim.g.gitblame_delay = 1000  -- ミリ秒
    
    -- バーチャルテキストの表示位置
    vim.g.gitblame_message_when_not_committed = 'まだコミットされていません'
    vim.g.gitblame_highlight_group = "LineNr"
    
    -- トグルするためのキーマッピング
    vim.keymap.set('n', '<leader>gt', ':GitBlameToggle<CR>', { desc = 'GitBlame表示切替' })
  end
}
