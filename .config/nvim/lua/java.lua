-- ============================================================================
-- Java LSP (jdtls) - REQUIRED for completion
-- ============================================================================

local jdtls = require("jdtls")

local root_markers = {
  "gradlew",
  "mvnw",
  "pom.xml",
  "build.gradle",
  "settings.gradle",
  ".git",
}

local root_dir = require("jdtls.setup").find_root(root_markers)
if not root_dir then
  return
end

-- Workspace directory (per project)
local workspace_dir = vim.fn.stdpath("data")
  .. "/jdtls-workspace/"
  .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-- Capabilities (CMP support)
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_ok, cmp = pcall(require, "cmp_nvim_lsp")
if cmp_ok then
  capabilities = cmp.default_capabilities(capabilities)
end

local config = {
  cmd = {
    "jdtls",
    "-data",
    workspace_dir,
  },

  root_dir = root_dir,
  capabilities = capabilities,

  settings = {
    java = {
      eclipse = { downloadSources = true },
      configuration = { updateBuildConfiguration = "interactive" },
      maven = { downloadSources = true },
      implementationsCodeLens = { enabled = true },
      referencesCodeLens = { enabled = true },
      format = { enabled = true },
    },
  },

  init_options = {
    bundles = {},
  },
}

jdtls.start_or_attach(config)

