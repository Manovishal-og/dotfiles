-- options:
vim.g.mapleader = " "
vim.opt.shortmess:append("F")
vim.o.ruler = false
vim.o.cmdheight = 0
vim.opt.statusline = " "
vim.opt.termguicolors = true
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.o.autochdir = false
vim.o.wrap = true
vim.o.linebreak = true
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.o.laststatus = 2
vim.opt.fillchars = { eob = " "}
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 2500
vim.opt.timeoutlen = 3000
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = false
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
-- colour schemes:
vim.opt.background = "dark" -- set this to dark or light

vim.api.nvim_set_keymap('i' , '<C-a>', '<Esc>', {noremap = true , silent = true})
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set('n', "<C-G>", "<C-w>w", { desc = "for toggling between floating docs and code" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set('n', '<leader>nd', '<cmd>NoiceDismiss<CR>', { desc = "Dismiss notify message" })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- hightlight the yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

--tabline :
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<M-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<M-.>', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<M->>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<M-<>', '<Cmd>BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<M-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<M-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<M-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<M-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<M-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<M-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<M-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<M-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<M-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<M-0>', '<Cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
map('n', '<M-P>', '<Cmd>BufferPin<CR>', opts)
-- Goto pinned/unpinned buffer
--                 :BufferGotoPinned
--                 :BufferGotoUnpinned
-- Close buffer
map('n', '<M-q>', '<Cmd>BufferClose<CR>', opts)
-- Wipeout buffer
--map('n', '<M-Q>', '<Cmd>BufferWipeout<CR>', opts)
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
--map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
-- Sort automatically by...
map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bn', '<Cmd>BufferOrderByName<CR>', opts)
map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used

-- Lazy package manager setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"NStefan002/screenkey.nvim",
		lazy = false,
		version = "*", -- or branch = "dev", to use the latest commit
		config = function()
			vim.keymap.set("n", "<leader>st", "<cmd>Screenkey toggle<CR>", { noremap = true, silent = true })
		end,
	},

	{
		"hat0uma/csvview.nvim",
		---@module "csvview"
		---@type CsvView.Options
		opts = {
			view = {
				display_mode = "border",
				header_lnum = true,
				sticky_header = {
					enabled = true,
					separator = "─",  -- Separator line character
				},

			},

			-- Default configuration with auto-detection

			parser = {
				delimiter = {
					ft = {
						csv = ",",        -- Always use comma for .csv files
						tsv = "\t",       -- Always use tab for .tsv files
					},
					fallbacks = {       -- Try these delimiters in order for other files
						",",              -- Comma (most common)
						"\t",             -- Tab
						";",              -- Semicolon
						"|",              -- Pipe
						":",              -- Colon
						" ",              -- Space
					},
				},
			},

			keymaps = {
				-- Text objects for selecting fields
				textobject_field_inner = { "if", mode = { "o", "x" } },
				textobject_field_outer = { "af", mode = { "o", "x" } },
				-- Excel-like navigation:
				-- Use <Tab> and <S-Tab> to move horizontally between fields.
				-- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
				-- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
				jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
				jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
				jump_next_row = { "<Enter>", mode = { "n", "v" } },
				jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
			},
		},
		cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
	},



	-- The Colorizer (as requested)
	{
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {
			filetypes = { "*" },
			user_default_options = {
				names = true,          -- This highlights "red", "blue", etc.
				RGB = true,            -- #RGB hex codes
				RRGGBB = true,         -- #RRGGBB hex codes
				AARRGGBB = true,       -- 0xAARRGGBB hex codes
				rgb_fn = true,         -- CSS rgb() and rgba() functions
				hsl_fn = true,         -- CSS hsl() and hsla() functions
				css = true,            -- Enable all CSS features
				css_fn = true,         -- Enable all CSS functions
				mode = "background",   -- Set to "foreground" if you only want the text colored
				tailwind = true,       -- Support tailwind colors
				sass = { enable = true, parsers = { "css" }, },
				virtualtext = "■",     -- Show a small square next to the color
			},
		},
	},


	{
		'mfussenegger/nvim-jdtls',
		ft = { "java" }, -- Only load when a Java file is opened
	},

	-- lazy.nvim
	-- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:


	{
		'numToStr/Comment.nvim',
		opts = {
			padding = true,
			---Whether the cursor should stay at its position
			sticky = true,
			---Lines to be ignored while (un)comment
			ignore = nil,
			---LHS of toggle mappings in NORMAL mode
			toggler = {
				---Line-comment toggle keymap
				line = 'gcc',
				---Block-comment toggle keymap
				block = 'gbc',
			},
			---LHS of operator-pending mappings in NORMAL and VISUAL mode
			opleader = {
				---Line-comment keymap
				line = 'gc',
				---Block-comment keymap
				block = 'gb',
			},
			---LHS of extra mappings
			extra = {
				---Add comment on the line above
				above = 'gcO',
				---Add comment on the line below
				below = 'gco',
				---Add comment at the end of line
				eol = 'gcA',
			},
			---Enable keybindings
			---NOTE: If given `false` then the plugin won't create any mappings
			mappings = {
				---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
				basic = true,
				---Extra mapping; `gco`, `gcO`, `gcA`
				extra = true,
			},
			---Function to call before (un)comment
			pre_hook = nil,
			---Function to call after (un)comment
			post_hook = nil,
		}
	},




	-- Example for Lazy.nvim
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function ()
			vim.cmd[[colorscheme tokyonight-storm]]

		end
	},


	{"mfussenegger/nvim-jdtls"},

	{
		'tribela/transparent.nvim',
		event = 'VimEnter',
		config = function()
			require('transparent').setup({
				auto = true,
				extra_groups = {
					-- Core UI
					"Normal",
					"NormalNC",
					"NormalFloat",
					"EndOfBuffer",
					"VertSplit",
					"StatusLine",
					"StatusLineNC",
					"WinSeparator",
					"TabLine",
					"TabLineFill",
					"TabLineSel",

					-- neo-tree
					"NeoTreeNormal",
					"NeoTreeNormalNC",
					"NeoTreeFloatBorder",
					"NeoTreeEndOfBuffer",
					"NeoTreeWinSeparator",

					-- barbar.nvim
					"BufferTabpageFill",
					"BufferVisible",
					"BufferInactive",
					"BufferVisibleMod",
					"BufferInactiveMod",
					"BufferCurrentMod",
					"BufferVisibleSign",
					"BufferInactiveSign",
					"BufferCurrentSign",

					-- telescope.nvim
					"TelescopeNormal",
					"TelescopeBorder",
					"TelescopePromptNormal",
					"TelescopePromptBorder",
					"TelescopeResultsNormal",
					"TelescopeResultsBorder",
					"TelescopePreviewNormal",
					"TelescopePreviewBorder",

					-- noice.nvim

					-- notify.nvim
					"NotifyINFOBody",
					"NotifyWARNBody",
					"NotifyERRORBody",
					"NotifyDEBUGBody",
					"NotifyTRACEBody",

					-- which-key.nvim
					"WhichKeyFloat",
					"WhichKeyBorder",


				},
				excludes = {}, -- optional: list filetypes to exclude from transparency
			})
		end,
	},





	-- lsp and autocompletion
	{ 'vonheikemen/lsp-zero.nvim',        branch = 'v4.x' },
	{ 'neovim/nvim-lspconfig' },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/nvim-cmp' },
	{ 'williamboman/mason.nvim' },
	{ 'williamboman/mason-lspconfig.nvim' },
	{'saadparwaiz1/cmp_luasnip'},
	{'l3mon4d3/luasnip'},
	-- animate





	{
		"vhyrro/luarocks.nvim",
		priority = 1000, -- very high priority is required, luarocks.nvim should run as the first plugin in your config.
		config = true,
		opts = {
			rocks = { "magick" },
		},
	},

	-- ~/.config/nvim/lazy.lua
	{
		'neovim/nvim-lspconfig',
		'hrsh7th/nvim-cmp',
		'hrsh7th/cmp-nvim-lsp',
		'L3MON4D3/LuaSnip',
		'saadparwaiz1/cmp_luasnip',
		'onsails/lspkind.nvim',
	},



	{
		'goolord/alpha-nvim',
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			-- set header
			dashboard.section.header.val = {

				[[                                                                       ]],
				[[                                                                     ]],
				[[       ████ ██████           █████      ██                     ]],
				[[      ███████████             █████                             ]],
				[[      █████████ ███████████████████ ███   ███████████   ]],
				[[     █████████  ███    █████████████ █████ ██████████████   ]],
				[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
				[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
				[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
				[[                                                                       ]],
			}


			-- set menu
			dashboard.section.buttons.val = {
				dashboard.button("e", "     new file", ":ene <bar> startinsert <cr>"),
				dashboard.button("spc ff", "󰈞     find file", "<cmd> telescope find_files<cr>"),
				dashboard.button("spc f.", "     recent", ":telescope oldfiles<cr>"),
				dashboard.button("s", "     settings", ":e ~/.config/ <cr>"),
				dashboard.button("q", "     quit nvim", ":qa<cr>"),
			}

			-- set footer
			--   note: this is currently a feature in my fork of alpha-nvim (opened pr #21, will update snippet if added to main)
			--   to see test this yourself, add the function as a dependecy in packer and uncomment the footer lines
			--   ```init.lua
			--   return require('packer').startup(function()
			--       use 'wbthomason/packer.nvim'
			--       use {
			--           'goolord/alpha-nvim', branch = 'feature/startify-fortune',
			--           requires = {'blakejc94/alpha-nvim-fortune'},
			--           config = function() require("config.alpha") end
			--       }
			--   end)
			--   ```
			local fortune = require("alpha.fortune")
			dashboard.section.footer.val = fortune()

			-- send config to alpha
			alpha.setup(dashboard.opts)

			-- disable folding on alpha buffer
			vim.cmd([[
					autocmd filetype alpha setlocal nofoldenable
					]])
		end
	},






	{
		'romgrk/barbar.nvim',
		dependencies = {
			'lewis6991/gitsigns.nvim', -- optional: for git status
			'nvim-tree/nvim-web-devicons', -- optional: for file icons
		},
		init = function() vim.g.barbar_auto_setup = false end,
		opts = {
			animation = true,
			insert_at_start = true,
			preset = 'slanted',
			insert_at_end = true, 

			-- sets the maximum padding width with which to surround each tab
			maximum_padding = 1,
			-- sets the minimum padding width with which to surround each tab
			minimum_padding = 1,
			-- sets the maximum buffer name length.
			maximum_length = 15,
			-- sets the minimum buffer name length.
			minimum_length = 0,
			-- …etc.
		},
		version = '^1.0.0', -- optional: only update when a new 1.x version is released
	},





	{
		"nvim-treesitter/nvim-treesitter",
		run = ":tsupdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"c",
					"cpp",
					"diff",
					"html",
					"lua",
					"luadoc",
					"markdown",
					"markdown_inline",
					"query",
					"vim",
					"vimdoc",
				},
				auto_install = true,
				highlight = { enable = true, additional_vim_regex_highlighting = { "ruby" } },
				indent = { enable = true, disable = { "ruby" } },
			})
		end
	}
	,
	{ -- fuzzy finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		event = "vimenter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- if encountering errors, see telescope-fzf-native readme for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- this is only run then, not every time neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },

			-- useful for getting pretty icons, but requires a nerd font.
			{ "nvim-tree/nvim-web-devicons",            enabled = vim.g.have_nerd_font },
		},
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- enable telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			-- see `:help telescope.builtin`
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[s]earch [k]eymaps" })
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[s]earch [f]iles" })
			vim.keymap.set("n", "<leader>ft", builtin.builtin, { desc = "[s]earch [s]elect telescope" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[s]earch by [g]rep" })
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[s]earch [d]iagnostics" })
			vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = '[s]earch recent files ("." for repeat)' })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[ ] find existing buffers" })


			--  see `:help telescope.builtin.live_grep()` for information about particular keys
			vim.keymap.set("n", "<leader>f/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "live grep in open files",
				})
			end, { desc = "[s]earch [/] in open files" })

			-- shortcut for searching your neovim configuration files
			vim.keymap.set("n", "<leader>fn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[s]earch [n]eovim files" })
		end,
	},

	{
		'nvim-neo-tree/neo-tree.nvim',
		version = '*',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
			'muniftanjim/nui.nvim',
		},
		cmd = 'Neotree',
		keys = {
			{ '\\', ':Neotree reveal<cr>', desc = 'neotree reveal', silent = true },
		},
		opts = {
			filesystem = {
				window = {
					mappings = {
						['\\'] = 'close_window',
					},
				},
			},
		},
	},


	{
		'windwp/nvim-autopairs',
		event = 'insertenter',
		-- optional dependency
		dependencies = { 'hrsh7th/nvim-cmp' },
		config = function()
			require('nvim-autopairs').setup {}
			-- if you want to automatically add `(` after selecting a function or method
			local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
			local cmp = require 'cmp'
			cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
		end,
	},

	--indent line
	{
		{ -- add indentation guides even on blank lines
			'lukas-reineke/indent-blankline.nvim',
			-- enable `lukas-reineke/indent-blankline.nvim`
			-- see `:help ibl`
			main = 'ibl',
			opts = {},
		},
	},
})

-- lsp config
local lsp_zero = require('lsp-zero')
local lsp_attach = function(client, bufnr)
	local opts = { buffer = bufnr }

	vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
	vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
	vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
	vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
	vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
	vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
	vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
	vim.keymap.set('n', '<f2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
	vim.keymap.set({ 'n', 'x' }, '<f3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
	vim.keymap.set('n', '<f4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
end

lsp_zero.extend_lspconfig({
	sign_text = true,
	lsp_attach = lsp_attach,
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

require('mason').setup({})
require('mason-lspconfig').setup({
	handlers = {
		function(server_name)
			require('lspconfig')[server_name].setup({})
		end,
	},
})

--auto completion

local cmp = require('cmp')
local luasnip = require 'luasnip'
cmp.setup({
	sources = {
		{ name = 'luasnip' },
		{ name = 'nvim_lsp' },
	},
	mapping = cmp.mapping.preset.insert({
		-- navigate between completion items
		['<c-p>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
		['<c-n>'] = cmp.mapping.select_next_item({ behavior = 'select' }),

		-- `enter` key to confirm completion
		['<cr>'] = cmp.mapping.confirm({ select = false }),

		-- ctrl+space to trigger completion menu
		['<c-space>'] = cmp.mapping.complete(),

		-- scroll up and down in the completion documentation
		['<c-u>'] = cmp.mapping.scroll_docs(-4),
		['<c-d>'] = cmp.mapping.scroll_docs(4),
	}),
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
})

-- borders
cmp.setup({
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function()
		require("java")
	end,
})
require('lsp')
require('cmp_config')
require('treesitter')
require('keymaps')
