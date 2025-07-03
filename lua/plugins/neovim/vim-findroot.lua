-------------------------------------------------- 
--- 開いたファイルのルートを判別してカレントディレクトリを変更する
--------------------------------------------------
return {
	'mattn/vim-findroot',
	config = function() 
		vim.g.findroot_patterns = {
			'.git/',
			'.svn/',
			'.hg/',
			'.bzr/',
			'.gitignore',
			'Rakefile',
			'pom.xml',
			'project.clj',
			'*.csproj',
			'*.sln',
			'init.lua',
		}
	end,
}
