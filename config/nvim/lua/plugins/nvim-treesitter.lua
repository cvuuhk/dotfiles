return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require('nvim-treesitter').install {'lua', 'c', 'cpp', 'bash', 'yaml', 'json', 'make', 'python'}
  end
}
