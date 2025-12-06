local lspconfig = require('lspconfig')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')

-- Setup Mason
mason.setup()
mason_lspconfig.setup {
  ensure_installed = {
    'pyright',
    'clangd',
    'lua_ls',
    'emmet_ls', -- HTML/CSS autocomplete
    -- Note: tsserver is excluded here (manual setup below)
  },
}

-- Capabilities and keymaps
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local on_attach = function(_, bufnr)
  local function buf_map(mode, lhs, rhs)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true })
  end
  buf_map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  buf_map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
  buf_map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  buf_map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  buf_map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  buf_map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
end

-- Configure manually
lspconfig.tsserver.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Configure other servers
local servers = {
  'pyright',
  'clangd',
  'lua_ls',
  'emmet_ls'
}

for _, server in ipairs(servers) do
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  if server == 'lua_ls' then
    opts.settings = {
      Lua = {
        diagnostics = { globals = { 'vim' } },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = { enable = false },
      },
    }
  end

  lspconfig[server].setup(opts)
end

-- Java support
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    local ok, jdtls = pcall(require, "jdtls")
    if not ok then
      vim.notify("nvim-jdtls not found!", vim.log.levels.ERROR)
      return
    end

    local home = os.getenv("HOME")
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_dir = home .. "/.local/share/eclipse/" .. project_name
    local jdtls_path = home .. "/.local/share/jdtls"

    local config = {
      cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=false',
        '-Dlog.level=ERROR',
        '-Xms256m',
        '-Xmx512m',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar'),
        '-configuration', jdtls_path .. '/config_linux',
        '-data', workspace_dir,
      },
      root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "build.gradle" }),
      settings = {
        java = {
          autobuild = { enabled = false },
          import = {
            gradle = { enabled = false },
            maven = { enabled = false },
          },
        }
      },
      init_options = { bundles = {} },
    }

    if config.root_dir then
      vim.defer_fn(function()
        jdtls.start_or_attach(config)
      end, 150)
    end
  end,
})
