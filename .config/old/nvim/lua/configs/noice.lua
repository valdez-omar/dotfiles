require("noice").setup {
  routes = {
    {
      filter = { event = "notify", find = "Highlight group 'NotifyBackground' has no background highlight" },
      opts = { skip = true },
    },
    { filter = { event = "notify", find = "No information available" }, opts = { skip = true } },
  },
  -- keymaps
  vim.keymap.set("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss Noice Message" }),
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
    hover = {
      enabled = false, -- disable the hover feature
    },
    signature = {
      enabled = false, -- disable the signature help feature
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = false, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
}
