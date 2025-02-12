---@type NvPluginSpec[]
return {
  -- Formatting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      require "configs.conform"
    end,
  },

  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require "configs.lualine"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "configs.treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-telescope/telescope-project.nvim", "jvgrootveld/telescope-zoxide" },
    opts = require "configs.telescope",
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = require "configs.nvim-tree",
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = {
      auto_install = true,
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "css-lsp",
        "html-lsp",
        "typescript-language-server",
        "astro-language-server",
        "tailwindcss-language-server",
        "shfmt",
        "black",
        "isort",
        "ruff",
        "pyright",
        "prettier",
        "nomicfoundation-solidity-language-server",
        "sqlfluff",
      },
    },
  },
  -- Better escape
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  -- nvim-web-devicons
  {
    "nvim-tree/nvim-web-devicons",
  },
  -- -- yazi nvim
  -- {
  --   "DreamMaoMao/yazi.nvim",
  --   dependencies = {
  --     "nvim-telescope/telescope.nvim",
  --     "nvim-lua/plenary.nvim",
  --   },
  --   keys = {
  --     { "<leader>gy", "<cmd>Yazi<CR>", desc = "Toggle Yazi" },
  --   },
  -- },
  -- aerial nvim
  {
    "stevearc/aerial.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>af", "<cmd>AerialToggle!<CR>" },
    },
  },
  -- -- iron nvim
  -- {
  --   "hkupty/iron.nvim",
  --   ft = "python",
  --   config = function()
  --     require "configs.iron"
  --   end,
  -- },
  -- -- gen nvim
  -- {
  --   "David-Kunz/gen.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require "configs.gen"
  --   end,
  -- },
  -- smooth scroll
  {
    "karb94/neoscroll.nvim",
    keys = { "<C-d>", "<C-u>" },
    config = function()
      require("neoscroll").setup()
    end,
  },
  -- vim tmux navigator
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  -- mini.nvim
  { "echasnovski/mini.nvim", version = false },
  -- -- codewindow nvim
  -- {
  --   "gorbit99/codewindow.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require "configs.codewindow"
  --   end,
  -- },
  -- noice.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
      require "configs.noice"
    end,
    opts = {
      -- add any options here
      routes = {
        filter = { event = "notify", find = "No information available" },
        opts = { skip = true },
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },

  -- Override plugin definition options
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "nvchad.configs.lspconfig"
      require "configs.lsp"
    end, -- Override to setup mason-lspconfig
  },

  -- -- AI Completion
  -- {
  --   "hrsh7th/nvim-cmp",
  --   config = function(_, opts)
  --     table.insert(opts.sources, { name = "codeium" })
  --     require("cmp").setup(opts)
  --   end,
  --   dependencies = {
  --     {
  --       "jcdickinson/codeium.nvim",
  --       event = "VeryLazy",
  --       config = function()
  --         require("codeium").setup {}
  --       end,
  --     },
  --   },
  -- },
  {
    "mrjones2014/smart-splits.nvim",
  },

  -- {
  --   "Exafunction/codeium.vim",
  --   enabled = true,
  --   config = function()
  --     vim.g.codeium_no_map_tab = true
  --     vim.keymap.set("i", "<C-y>", function()
  --       return vim.fn["codeium#Accept"]()
  --     end, { expr = true }) -- Accept completion is Ctrl + g
  --     --[[ vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
  --     vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
  --     vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true }) ]]
  --
  --     --[[ Clear current suggestion 	codeium#Clear() 	<C-]>
  --     Next suggestion 	codeium#CycleCompletions(1) 	<M-]>
  --     Previous suggestion 	codeium#CycleCompletions(-1) 	<M-[>
  --     Insert suggestion 	codeium#Accept() 	<Tab>
  --     Manually trigger suggestion 	codeium#Complete() 	<M-Bslash> ]]
  --   end,
  --   event = "InsertEnter",
  -- },

  -- -- Cmake
  -- {
  --   "Civitasv/cmake-tools.nvim",
  --   enabled = true,
  --   cmd = { "CMakeBuild" },
  --   opts = {},
  -- },

  -- -- LaTeX
  -- {
  --   "lervag/vimtex",
  --   ft = "tex",
  --   config = function()
  --     require("configs.vimtex").setup()
  --   end,
  -- },

  -- Rust
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = { "rust" },
    config = function()
      vim.g.rustaceanvim = {
        inlay_hints = { auto = false },
        tools = { hover_actions = { auto_focus = true } },
        server = {
          on_init = require("nvchad.configs.lspconfig").on_init,
          capabilities = require("nvchad.configs.lspconfig").capabilities,
          on_attach = function(client, bufnr)
            require("nvchad.configs.lspconfig").on_attach(client, bufnr)
            -- require("lsp-inlayhints").on_attach(client, bufnr)
            if client.server_capabilities.inlayHintProvider then
              vim.lsp.inlay_hint(bufnr, true)
            end
          end,
        },
      }
    end,
  },

  -- LSP diagnostics
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle" },
    config = function()
      dofile(vim.g.base46_cache .. "trouble")
      require("trouble").setup()
    end,
  },

  {
    "folke/which-key.nvim",
    keys = function()
      ---@type (string|LazyKeymaps)[]
      return { "<leader>" }
    end,
    opts = {
      motions = { count = false },
      plugins = {
        marks = false,
        registers = false,
        presets = {
          operators = false,
          motions = false,
          text_objects = false,
          windows = false,
          nav = true,
          z = true,
          g = true,
        },
      },
    },
  },
}
