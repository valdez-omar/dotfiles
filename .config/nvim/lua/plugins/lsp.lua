-- Ensure you have Mason and Mason-LSPConfig set up
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"ruff",
		"pyright",
		"html",
		"cssls",
		"dockerls",
		"terraformls",
		"yamlls",
		"sqlls",
		"gopls",
		"ts_ls",
		"tailwindcss",
		"lua_ls",
		"bashls",
	},
	automatic_installation = true,
})

local lspconfig = require("lspconfig")

-- Define capabilities for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Common on_attach function for key mappings
local function on_attach(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local opts = { noremap = true, silent = true }

	-- Key mappings
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

	-- Set some keybinds conditional on server capabilities
	if client.server_capabilities.documentFormattingProvider then
		buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	elseif client.server_capabilities.documentRangeFormattingProvider then
		buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
	end
end

-- Python configuration (Ruff and Pyright)
lspconfig.ruff.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	init_options = {
		settings = {
			args = {},
		},
	},
})

lspconfig.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "basic",
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
			},
		},
	},
})

-- Golang configuration
lspconfig.gopls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
})

-- Terraform configuration
lspconfig.terraformls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- Docker configuration
lspconfig.dockerls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- YAML configuration
lspconfig.yamlls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		yaml = {
			schemas = {
				["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
				["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.yml",
			},
		},
	},
})

-- SQL configuration
lspconfig.sqlls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- HTML configuration
lspconfig.html.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- CSS configuration
lspconfig.cssls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- Tailwind CSS configuration
lspconfig.tailwindcss.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- Lua configuration
lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,

	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
			},
		},
	},
})

-- Bash configuration
lspconfig.bashls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- TypeScript/JavaScript configuration
-- lspconfig.tsserver.setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- })

-- Enable the sign column always
vim.opt.signcolumn = "yes"
