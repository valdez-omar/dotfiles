-- Install lazylazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Fixes Notify opacity issues
vim.o.termguicolors = true

--
-- SETUP
--

require("lazy").setup({
	--
	-- COMMENTS
	--

	-- gc comments
	{
		"numToStr/Comment.nvim", -- "gc" to comment visual regions/lines
		event = { "BufRead", "BufNewFile" },
		config = true,
	},

	-- hihglight and search for todo comments
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	},

	--
	-- THEME
	--

	-- theme
	{ "catppuccin/nvim", as = "catppuccin" },

	--
	-- TELESCOPE
	--

	-- Fuzzy Finder (files, lsp, etc)
	{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },

	-- tele symbols
	"nvim-telescope/telescope-symbols.nvim",

	-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },

	--
	-- GIT
	--

	-- git decorations
	"lewis6991/gitsigns.nvim",

	-- git worktree
	"ThePrimeagen/git-worktree.nvim",

	--
	-- CODE
	--

	-- disables certain fetaures if the opened file is big
	"LunarVim/bigfile.nvim",

	-- vscode lsp like pictograms to neovim
	"onsails/lspkind.nvim",

	-- showing diagnostics, references, telescope results
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},

	-- format
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
	},

	-- vim tmux navigator
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},

	"mrjones2014/smart-splits.nvim",

	-- Highlight, edit, and navigate code
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
	},

	-- LSP configurations & plugins
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Completion framework
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			-- Useful status updates for LSP
			"j-hui/fidget.nvim",
		},
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			-- nvim-cmp setup
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				view = {
					entries = "native",
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "neorg" },
				},
			})
		end,
	},

	-- autopair plugin
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},

	--
	-- MARKDOWN
	--

	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		ft = { "markdown" },
		opts = {},
	},

	-- tool for writers
	"preservim/vim-pencil",

	--
	-- UI
	--
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			dashboard.section.header.val = {
				"                                                     ",
				"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
				"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
				"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
				"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
				"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
				"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
				"                                                     ",
			}
			-- Set the highlight group for the header
			vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#a6e3a1" })

			-- Apply the highlight to the header
			dashboard.section.header.opts.hl = "AlphaHeader"

			dashboard.section.buttons.val = {
				dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
				dashboard.button("y", "󰪶  Open file manager", ":Yazi<CR>"),
				dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
				dashboard.button("t", "󱎸  Find text", ":Telescope live_grep <CR>"),
				dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua<CR>"),
				dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
			}

			alpha.setup(dashboard.config)
		end,
	},

	-- UI for messages, cmdline and popmenu
	-- {
	-- 	"folke/noice.nvim",
	-- 	config = function()
	-- 		require("trouble").setup({})
	-- 	end,
	-- 	dependencies = {
	-- 		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
	-- 		"MunifTanjim/nui.nvim",
	-- 		"rcarriga/nvim-notify",
	-- 	},
	-- },

	-- -- make nvim transparent toggle
	-- {
	-- 	"xiyaowong/nvim-transparent",
	-- 	-- config = function()
	-- 	-- 	require("transparent").clear_prefix("NeoTree")
	-- 	-- end,
	-- },

	-- Yazi
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		keys = {
			-- 👇 in this section, choose your own keymappings!
			{
				"<leader>-",
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				-- Open in the current working directory
				"<leader>cw",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
			{
				-- NOTE: this requires a version of yazi that includes
				-- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
				"<c-up>",
				"<cmd>Yazi toggle<cr>",
				desc = "Resume the last yazi session",
			},
		},
		opts = {
			-- if you want to open yazi instead of netrw, see below for more info
			open_for_directories = false,
			keymaps = {
				show_help = "<f1>",
			},
		},
	},

	-- Fancier statusline
	"nvim-lualine/lualine.nvim",

	-- Indent guides
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

	-- -- Neo Tree
	-- {
	-- 	"nvim-neo-tree/neo-tree.nvim",
	-- 	branch = "v3.x",
	-- 	config = function()
	-- 		vim.keymap.set("n", "<C-n>", function()
	-- 			vim.cmd("Neotree toggle float")
	-- 		end)
	-- 	end,
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
	-- 		"MunifTanjim/nui.nvim",
	-- 		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	-- 	},
	-- },

	-- gen nvim
	{
		"David-Kunz/gen.nvim",
		event = "VeryLazy",
		opts = {
			model = "llama3.2:latest",
			quit_map = "q",
			retry_map = "<c-r>",
			accept_map = "<c-cr>",
		},
	},

	-- {
	--   "Exafunction/codeium.vim",
	--   event = "InsertEnter",
	--  config = function ()
	--     -- Change "<C-g>" here to any keycode you like.
	--     vim.keymap.set("i", "<C-e>", function () return vim.fn["codeium#Accept"]() end, { expr = true, silent = true })
	--     vim.keymap.set("i", "<c-n>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true, silent = true })
	--     vim.keymap.set("i", "<c-p>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true, silent = true })
	--     vim.keymap.set("i", "<c-x>", function() return vim.fn["codeium#Clear"]() end, { expr = true, silent = true })
	--   end
	-- },

	-- parrot nvim
	-- {
	-- 	"frankroeder/parrot.nvim",
	-- 	event = "VeryLazy",
	-- 	dependencies = { "ibhagwan/fzf-lua", "nvim-lua/plenary.nvim" },
	-- 	config = function()
	-- 		require("parrot").setup({
	-- 			-- Providers must be explicitly added to make them available.
	-- 			providers = {
	-- 				anthropic = {
	-- 					api_key = os.getenv("ANTHROPIC_API_KEY"),
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },

	-- "ray-x/go.nvim",

	-- {
	--   "rcarriga/nvim-dap-ui",
	--   dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"}
	-- },

	-- "theHamsta/nvim-dap-virtual-text",

	-- "leoluz/nvim-dap-go",
})
