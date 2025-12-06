
-- ~/.config/nvim/lua/treesitter.lua
require('nvim-treesitter.configs').setup {
	ensure_installed = {
		'c', 'cpp', 'lua', 'python', 'java',
		'javascript', 'typescript', 'tsx', 'json', 'html', 'css'
	},  highlight = {
		enable = true,
	},
	require("lspconfig").qmlls.setup {
		cmd = {"qmlls", "-E"}
	}
}
