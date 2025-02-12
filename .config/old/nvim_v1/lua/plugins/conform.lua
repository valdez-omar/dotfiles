local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		sh = { "shfmt" },
		markdown = { "prettier" },
		jsonc = { "prettier" },
		yaml = { "prettier" },
		sql = { "sqlfluff" },
		go = { "goimports" },
	},

	linters_by_ft = {
		python = { "ruff", "pyright" }, -- Add any other linters you want
	},

	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})
