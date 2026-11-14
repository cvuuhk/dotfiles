return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local parsers = {'lua', 'c', 'cpp', 'bash', 'yaml', 'json', 'make', 'python'}
    require('nvim-treesitter').install(parsers)

    -- nvim-treesitter main 不再自动开启高亮,需要显式 start
    vim.api.nvim_create_autocmd('FileType', {
      pattern = {'lua', 'c', 'cpp', 'sh', 'bash', 'yaml', 'json', 'make', 'python'},
      callback = function(ev)
        pcall(vim.treesitter.start, ev.buf)
      end
    })
  end
}
