-- ~/.config/nvim/lua/plugins.lua

return {
  -- LSP
  { 'neovim/nvim-lspconfig' },
  { 'williamboman/mason.nvim', build = ':MasonUpdate', config = true },
  { 'williamboman/mason-lspconfig.nvim', config = true },

  -- CMP (completion)
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },

  -- Snippets
  { 'L3MON4D3/LuaSnip' },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'rafamadriz/friendly-snippets' },

  -- Treesitter
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

  -- Java LSP
  {
    'mfussenegger/nvim-jdtls',
    ft = { "java" },
  },
}
