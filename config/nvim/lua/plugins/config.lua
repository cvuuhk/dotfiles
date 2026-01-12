return {
  {
    "itchyny/vim-cursorword",
  },
  {
    "sainnhe/gruvbox-material",
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-material",
    },
  },
  {
    "snacks.nvim",
    opts = {
      scroll = { enabled = false },
      dashboard = { enabled = false },
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        ghost_text = { enabled = false },
        list = {
          selection = {
            preselect = true,
            auto_insert = false,
          },
        },
        menu = {
          max_height = 30,
        },
      },
    },
  },
  {
    "junegunn/vim-easy-align",
    keys = {
      { "<leader>al", "<Plug>(EasyAlign)", mode = { "n", "x" }, desc = "Align Text" },
    },
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     diagnostics = {
  --       virtual_text = false,
  --     },
  --   },
  -- },
}
