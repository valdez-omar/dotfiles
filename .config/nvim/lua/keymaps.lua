vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- For conciseness
local opts = { noremap = true, silent = true }

-- buffers
vim.api.nvim_set_keymap("n", "tk", ":blast<enter>", { noremap = false })
vim.api.nvim_set_keymap("n", "tj", ":bfirst<enter>", { noremap = false })
vim.api.nvim_set_keymap("n", "th", ":bprev<enter>", { noremap = false })
vim.api.nvim_set_keymap("n", "tl", ":bnext<enter>", { noremap = false })
vim.api.nvim_set_keymap("n", "td", ":bdelete<enter>", { noremap = false })

-- toggle
-- vim.api.nvim_set_keymap("n", "TT", ":TransparentToggle<CR>", { noremap = true })

-- terminal
-- vim.api.nvim_set_keymap("n", "<leader>vt", ":vert new | terminal<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>ht", ":new | terminal<CR>", { noremap = true, silent = true })

-- clear highlights
vim.keymap.set("n", "<Esc>", ":noh<CR>", opts)

-- tmux
vim.api.nvim_set_keymap(
	"n",
	"<C-h>",
	":lua require('tmux').move_left()<CR>",
	{ noremap = true, silent = true, desc = "Window left" }
)
vim.api.nvim_set_keymap(
	"n",
	"<C-l>",
	":lua require('tmux').move_right()<CR>",
	{ noremap = true, silent = true, desc = "Window right" }
)
vim.api.nvim_set_keymap(
	"n",
	"<C-j>",
	":lua require('tmux').move_down()<CR>",
	{ noremap = true, silent = true, desc = "Window down" }
)
vim.api.nvim_set_keymap(
	"n",
	"<C-k>",
	":lua require('tmux').move_up()<CR>",
	{ noremap = true, silent = true, desc = "Window up" }
)

-- Resize with arrows
vim.keymap.set("n", "<Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<Right>", ":vertical resize +2<CR>", opts)

-- Window management
vim.keymap.set("n", "<leader>v", "<C-w>v", opts) -- split window vertically
vim.keymap.set("n", "<leader>h", "<C-w>s", opts) -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", opts) -- make split windows equal width & height
vim.keymap.set("n", "<leader>xs", ":close<CR>", opts) -- close current split window

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', opts)

-- Explicitly yank to system clipboard (highlighted and entire row)
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]g", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Save and load session
vim.keymap.set("n", "<leader>ss", ":mksession! .session.vim<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>sl", ":source .session.vim<CR>", { noremap = true, silent = false })
