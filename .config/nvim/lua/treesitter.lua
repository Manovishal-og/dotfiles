-- ============================================================================
-- TREESITTER CONFIG (Neovim 0.9 → 0.11 safe)
-- NO lspconfig dependency
-- ============================================================================

local ok, ts_configs = pcall(require, "nvim-treesitter.configs")
if not ok then
  return
end

ts_configs.setup({
  ensure_installed = {
    "c",
    "cpp",
    "lua",
    "python",
    "java",
    "bash",
    "json",
    "html",
    "css",
    "javascript",
    "typescript",
    "vim",
    "query",
    "markdown",
    "markdown_inline",
  },

  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true,
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
})
