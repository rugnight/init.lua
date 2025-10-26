return {
    -- 絵文字サポートの追加
    'nvim-tree/nvim-web-devicons',
    config = function()
        require('nvim-web-devicons').setup {
            default = true,
            strict = true,
        }
    end
}
