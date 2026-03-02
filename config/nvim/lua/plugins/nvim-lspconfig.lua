return {
  'neovim/nvim-lspconfig',
  config = function()
    vim.lsp.enable({'lua_ls', 'clangd', 'vue_ls', 'ts_ls'})
    vim.lsp.config('ts_ls', {
      filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'vue',
      }
    })
  end
}
