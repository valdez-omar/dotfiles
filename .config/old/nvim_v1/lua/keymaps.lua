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

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Key mappings for navigating diagnostics
vim.keymap.set("n", "]g", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
