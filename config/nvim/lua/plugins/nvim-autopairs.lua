return {
  'windwp/nvim-autopairs',
  event = "InsertEnter",
  config = true,
  opts = {
    disable_in_macro = true,
    disable_in_visualblock = false,
    disable_in_replace_mode = true,
  }
}
