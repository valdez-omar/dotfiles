-- Ensure you have Mason and Mason-LSPConfig set up
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "ruff", "html", "cssls", "pyright", "gopls", "tailwindcss", "lua_ls", "bashls" },
})

local lspconfig = require("lspconfig")

-- Define capabilities for completion (optional)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Common on_attach function for key mappings
local function on_attach(client, bufnr)
	local function nmap(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end
		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	-- Hover and signature help
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

	-- Workspace management
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")

	-- Format command
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		if client.server_capabilities.document_formatting then
			vim.lsp.buf.format()
		elseif client.server_capabilities.formatting then
			vim.lsp.buf.formatting()
		end
	end, { desc = "Format current buffer with LSP" })
end

-- Setup individual language servers with their specific settings

-- Python (pyright)
lspconfig.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- HTML
lspconfig.html.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- Tailwind CSS
lspconfig.tailwindcss.setup({
	init_options = {
		userLanguages = { stpl = "html" },
	},
})

-- -- Clangd (C/C++)
-- lspconfig.clangd.setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- })

-- Lua (lua_ls)
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

vim.opt.signcolumn = "yes"
