vim.g.mapleader = " "
vim.g.maplocalleader = " " -- Used for <LocalLeader>a mapping below
local opts = { noremap = true, silent = true }

-- buffers
vim.api.nvim_set_keymap("n", "tk", ":blast<enter>", { noremap = false })
vim.api.nvim_set_keymap("n", "tj", ":bfirst<enter>", { noremap = false })
vim.api.nvim_set_keymap("n", "th", ":bprev<enter>", { noremap = false })
vim.api.nvim_set_keymap("n", "tl", ":bnext<enter>", { noremap = false })
vim.api.nvim_set_keymap("n", "td", ":bdelete<enter>", { noremap = false })
-- clear highlights
vim.keymap.set("n", "<Esc>", ":noh<CR>", opts)
-- tmux (ensure require('tmux') works in your setup or adjust)
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
-- Explicitly yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
-- Better default experience
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
-- Diagnostic keymaps
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
-- Save and load session
vim.keymap.set("n", "<leader>ss", ":mksession! .session.vim<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>sl", ":source .session.vim<CR>", { noremap = true, silent = false })

--------------------------------------------------
-- CodeCompanion keymaps
--------------------------------------------------

-- Suggested Workflow Keymaps from Documentation
vim.keymap.set(
	{ "n", "v" },
	"<C-a>",
	"<cmd>CodeCompanionActions<cr>",
	{ noremap = true, silent = true, desc = "CodeCompanion Actions" }
)
vim.keymap.set(
	{ "n", "v" },
	"<LocalLeader>a",
	"<cmd>CodeCompanionChat Toggle<cr>",
	{ noremap = true, silent = true, desc = "Toggle CodeCompanion Chat" }
)
vim.keymap.set(
	"v",
	"ga",
	"<cmd>CodeCompanionChat Add<cr>",
	{ noremap = true, silent = true, desc = "Add selection to Chat" }
)

-- Other common commands (adjust as needed)
vim.keymap.set("n", "<leader>cc", "<cmd>CodeCompanionChat<cr>", { desc = "Open Chat" })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
