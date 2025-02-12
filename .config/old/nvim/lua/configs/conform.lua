local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    sh = { "shfmt" },
    astro = { "prettier" },
    markdown = { "deno_fmt" },
    jsonc = { "deno_fmt" },
    yaml = { "prettier" },
    tex = { "latexindent" },
    bib = { "latexindent" },
    rust = { "rustfmt" },
    sql = { "sqlfluff" },
  },
  linters_by_ft = {
    python = { "ruff", "pyright" },
  },
  format_on_save = { timeout_ms = 500, lsp_fallback = true },
}

require("conform").setup(options)
