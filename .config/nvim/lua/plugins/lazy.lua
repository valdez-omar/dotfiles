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
		event = "VeryLazy",
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

	-- gp.nvim AI chat session
	{
		"robitx/gp.nvim",
		event = "VeryLazy",
		config = function()
			local conf = {
				providers = {
					groq = {
						disable = false,
						endpoint = "https://api.groq.com/openai/v1/chat/completions",
						secret = os.getenv("GROQ_API_KEY"),
					},
					openai = {
						disable = true,
						endpoint = "https://api.openai.com/v1/chat/completions",
						-- secret = os.getenv("OPENAI_API_KEY"),
					},
				},
				agents = {
					{
						name = "ChatGroqLlama3.2-90B-vision-preview",
						provider = "groq",
						chat = true,
						command = false,
						-- string with model name or table with model name and parameters
						model = {
							model = "llama-3.2-90b-vision-preview",
							temperature = 0.6,
							top_p = 1,
							min_p = 0.05,
						},
						system_prompt = require("gp.defaults").chat_system_prompt,
					},
					{
						name = "CodeGroqLlama3.2-90B",
						provider = "groq",
						chat = false,
						command = true,
						model = {
							model = "llama-3.2-90b-vision-preview",
							temperature = 0.4,
							top_p = 1,
							min_p = 0.05,
						},
						system_prompt = require("gp.defaults").code_system_prompt,
					},
				},
			}
			require("gp").setup(conf)

			-- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
			vim.keymap.set("v", "<C-g>r", ":<C-u>'<,'>GpRewrite<cr>", { desc = "Visual Rewrite", noremap = true })
			vim.keymap.set("v", "<C-g>a", ":<C-u>'<,'>GpAppend<cr>", { desc = "Visual Append ", noremap = true })
			vim.keymap.set("v", "<C-g>b", ":<C-u>'<,'>GpPrepend<cr>", { desc = "Visual Prepend ", noremap = true })
			vim.keymap.set(
				"v",
				"<C-g>i",
				":<C-u>'<,'>GpImplement<cr>",
				{ desc = "Implement selection", noremap = true }
			)
		end,
	},

	-- codeium
	{
		"Exafunction/codeium.vim",
		event = "BufEnter",
		config = function()
			-- Change "<C-g>" here to any keycode you like.
			vim.keymap.set("i", "<C-e>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<c-n>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<c-p>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<c-x>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true, silent = true })
		end,
	},

	-- disables certain fetaures if the opened file is big
	"LunarVim/bigfile.nvim",

	-- vscode lsp like pictograms to neovim
	"onsails/lspkind.nvim",

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
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("plugins.autocompletion").setup()
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
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
	},

	-- Indent guides
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
})
