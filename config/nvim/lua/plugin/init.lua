-- base {{{
  local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
  end

  local config = require('plugin/config')
  require('packer').startup(function(use)
    use {'wbthomason/packer.nvim'}
    -- }}}
    -- editor ----------------------------------------------------------
    use 'itchyny/vim-cursorword' -- highlight cursor word
    use {'eddyekofo94/gruvbox-flat.nvim', opt = false, config = config.gruvbox_flat} -- theme
    use {'sainnhe/edge', opt = true, config = config.edge} -- theme
    use { -- powerful code highlighter
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = config.nvim_treesitter
  }
  use { -- show git status
  'lewis6991/gitsigns.nvim',
  requires = 'nvim-lua/plenary.nvim',
  config = config.gitsigns
}
-- tool ------------------------------------------------------------
use({
  "iamcco/markdown-preview.nvim",
  run = function() vim.fn["mkdp#util#install"]() end,
  opt = true,
  ft = {'markdown'}
})
use {
  'norcalli/nvim-colorizer.lua',
  opt = true,
  cmd = 'ColorizerToggle',
  config = config.nvim_colorizer
} -- display detected color
use 'junegunn/vim-easy-align' -- align code
use {'mhartington/formatter.nvim', opt = true, config = config.format, cmd = {'Format'}}
use { -- outline
'simrat39/symbols-outline.nvim',
opt = true,
config = config.symbols_outline,
cmd = {'SymbolsOutline'}
    }
    use { -- comment code quickly
    'numToStr/Comment.nvim',
    config = config.Comment
  }
  use { -- enhance the native motions
  'phaazon/hop.nvim',
  opt = true,
  config = config.hop,
  cmd = {'HopChar1', 'HopChar2'}
}
use "numtostr/FTerm.nvim" -- float terminal
use { -- explore files
'kyazdani42/nvim-tree.lua',
opt = true,
config = config.nvim_tree,
cmd = {'NvimTreeToggle', 'NvimTreeOpen'},
requires = {'kyazdani42/nvim-web-devicons'}
    }
    use { -- search files
    'nvim-telescope/telescope.nvim',
    opt = true,
    cmd = 'Telescope',
    config = config.telescope,
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  -- completion ------------------------------------------------------
  use {
    'hrsh7th/nvim-cmp', -- Autocompletion plugin
    requires = {
      'hrsh7th/cmp-buffer', -- buffer source for nvim-cmp
      'hrsh7th/cmp-path', -- path source for nvim-cmp
      'hrsh7th/cmp-nvim-lua', -- lua source for nvim-cmp
      'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
      'saadparwaiz1/cmp_luasnip', -- luasnip source for nvim-cmp
      'L3MON4D3/LuaSnip' -- snippets completion engine for nvim-cmp
    },
    config = config.nvim_cmp
  }
  use { -- tabnine source for nvim-cmp
  'tzachar/cmp-tabnine',
  run = './install.sh',
  requires = 'hrsh7th/nvim-cmp'
}
use {
  'windwp/nvim-autopairs',
  opt = true,
  ft = {'rust', 'c', 'cpp'},
  config = config.nvim_autopairs
}
use { -- native lsp client config
'neovim/nvim-lspconfig',
after = 'cmp-nvim-lsp',
config = config.lspconfig
    }
  end)

  local map = vim.api.nvim_set_keymap
  -- colorizer
  map('n', '<leader>c', ':ColorizerToggle<CR>', {noremap = true, silent = true})

  -- vim-easy-align
  map('x', '<leader>al', ':EasyAlign<CR>', {noremap = false})
  map('n', '<leader>al', ':EasyAlign<CR>', {noremap = false})

  -- hop
  map('n', 's', ':HopChar2<CR>', {noremap = false, silent = true})
  map('n', '<leader>s', ':HopChar1<CR>', {noremap = false, silent = true})

  -- telescope
  map('n', '<leader>ff', ':Telescope find_files<CR>', {noremap = true})
  map('n', '<leader>fg', ':Telescope live_grep<CR>', {noremap = true})
  map('n', '<leader>fb', ':Telescope buffers<CR>', {noremap = true})
  map('n', '<leader>fh', ':Telescope help_tags<CR>', {noremap = true})

  -- nvim-tree
  map('n', '<leader>v', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

  -- outline
  map('n', '<leader>t', ':SymbolsOutline<CR>', {noremap = true})

  -- fterm
  map('n', '<space>', ':w<CR>:lua require("FTerm").toggle()<CR>', {noremap = true, silent = true})
