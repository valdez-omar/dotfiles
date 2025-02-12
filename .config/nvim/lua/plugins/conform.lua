local conform = require "conform"

conform.setup {
  formatters_by_ft = {
    lua = { "stylua" },
    -- Python: comprehensive formatting with import sorting and fixes
    python = {
      "ruff_format", -- Primary formatter
      "ruff_fix", -- Code fixes
    },
    -- Web development
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    jsonc = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },

    -- Infrastructure and DevOps
    terraform = {
      "terraform_fmt",
    },
    dockerfile = { "prettier" },

    -- Shell scripting
    sh = { "shfmt" },
    bash = { "shfmt" },

    -- Golang
    go = {
      "goimports", -- Handles imports
      "gofmt", -- Standard formatting
    },

    -- SQL
    sql = { "sql-formatter" },
  },

  -- Format options
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
    async = false,
  },

  -- Notify on formatting errors
  notify_on_error = true,
}

-- Key mappings for manual formatting
vim.keymap.set({ "n", "v" }, "<leader>mp", function()
  conform.format {
    lsp_fallback = true,
    async = false,
    timeout_ms = 500,
  }
end, { desc = "Format file or range (in visual mode)" })
