-- Set colorscheme
vim.cmd([[colorscheme tokyonight-storm]])
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#8bd5ca" })

-- Enable cursorline to highlight the current line
vim.wo.cursorline = true

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true
vim.o.relativenumber = true

-- Disable mouse mode
vim.o.mouse = ""

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

--vim.cmd()
vim.opt.clipboard = "unnamedplus"

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- Concealer for Neorg
vim.o.conceallevel = 2

-- Creates a backup file
vim.o.backup = false

-- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.o.writebackup = false

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- creates a swapfile
vim.o.swapfile = false

-- we don't kneed to see things like -- INSERT -- anymore
vim.o.showmode = false

-- disable ruler
vim.o.ruler = false

-- Disable Netrw
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
