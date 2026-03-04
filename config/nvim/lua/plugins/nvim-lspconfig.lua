return {
  'neovim/nvim-lspconfig',
  config = function()
    local vue_plugin = {
      name = '@vue/typescript-plugin',
      location = vim.fn.stdpath('data') .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
      languages = { 'vue' },
      configNamespace = 'typescript',
    }

    local ts_ls_config = {
      init_options = {
        plugins = { vue_plugin },
      },
      filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
    }

    -- If you are on most recent `nvim-lspconfig`
    local vue_ls_config = {}
    -- nvim 0.11 or above
    vim.lsp.config('vue_ls', vue_ls_config)
    vim.lsp.config('ts_ls', ts_ls_config)

    vim.lsp.enable({'lua_ls', 'clangd', 'vue_ls', 'ts_ls'})
  end
}
