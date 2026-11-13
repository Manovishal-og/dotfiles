-- ============================================================================
-- LSP CONFIG (Neovim 0.10 + 0.11 compatible, future-proof)
-- ============================================================================

local function safe_require(mod)
	local ok, lib = pcall(require, mod)
	return ok and lib or nil
end

local has_new_lsp = vim.lsp.config ~= nil

local mason = safe_require("mason")
local mason_lspconfig = safe_require("mason-lspconfig")
local lspconfig = safe_require("lspconfig")


-- --------------------------------------------------------------------
-- Force bordered floating windows for ALL LSP hovers (including jdtls)
-- --------------------------------------------------------------------
local orig_open_floating_preview = vim.lsp.util.open_floating_preview

function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded"
  opts.focusable = true
  return orig_open_floating_preview(contents, syntax, opts, ...)
end


-- --------------------------------------------------------------------
-- Capabilities (cmp-safe)
-- --------------------------------------------------------------------
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp = safe_require("cmp_nvim_lsp")
if cmp_nvim_lsp then
	capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end


-- --------------------------------------------------------------------
-- LSP floating window borders (hover + signature help)
-- --------------------------------------------------------------------
vim.lsp.handlers["textDocument/hover"] =
vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded", -- "single" | "double" | "rounded" | "solid" | "shadow"
})

vim.lsp.handlers["textDocument/signatureHelp"] =
vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
})

-- --------------------------------------------------------------------
-- on_attach (non-destructive)
-- --------------------------------------------------------------------
local function on_attach(_, bufnr)
	local opts = { buffer = bufnr, silent = true }
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
end

-- --------------------------------------------------------------------
-- Shared base opts
-- --------------------------------------------------------------------
local base_opts = {
	capabilities = capabilities,
	on_attach = on_attach,
}

-- --------------------------------------------------------------------
-- Server-specific settings (YOUR SETTINGS LIVE HERE)
-- --------------------------------------------------------------------
local servers = {

	lua_ls = {
		settings = {
			Lua = {
				diagnostics = { globals = { "vim" } },
				telemetry = { enable = false },
			},
		},
	},

	clangd = {},

	pyright = {
		settings = {
			python = {
				analysis = {
					autoSearchPaths = true,
					diagnosticMode = "openFilesOnly",
				},
			},
		},
	},

}

-- --------------------------------------------------------------------
-- Mason
-- --------------------------------------------------------------------
if mason then
	mason.setup()
end

if mason_lspconfig then
	mason_lspconfig.setup({
		ensure_installed = vim.tbl_keys(servers),
	})
end

-- --------------------------------------------------------------------
-- NEW Neovim 0.11+ API
-- --------------------------------------------------------------------
if has_new_lsp then
	for name, opts in pairs(servers) do
		vim.lsp.config(name, vim.tbl_deep_extend("force", {}, base_opts, opts))
		vim.lsp.enable(name)
	end

	-- --------------------------------------------------------------------
	-- OLD API (Neovim 0.10 and below)
	-- --------------------------------------------------------------------
elseif lspconfig then
	for name, opts in pairs(servers) do
		lspconfig[name].setup(
			vim.tbl_deep_extend("force", {}, base_opts, opts)
		)
	end
end

-- --------------------------------------------------------------------
-- Diagnostics
-- --------------------------------------------------------------------
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
})
