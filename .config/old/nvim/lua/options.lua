require "nvchad.options"

vim.opt.foldlevel = 99
-- vim.opt.foldnestmax = 1
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.opt.relativenumber = true

-- vim.opt.conceallevel = 1
-- vim.o.scrolloff = 6
vim.opt.clipboard = "unnamedplus"
vim.o.statusline = "MODE: %{mode()} | %<%f | %=%l,%c | %P"

-- vim.opt.fillchars = { eob = "~" }

-- vim.opt.mouse = nil
vim.opt.pumheight = 8
vim.opt.showbreak = "↳ "
