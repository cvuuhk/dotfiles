local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerCompile
  augroup end
]])

local config = require('plugin/config')
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'itchyny/vim-cursorword'
  use { -- powerful code highlighter
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = config.nvim_treesitter
  }
  use {
    'sainnhe/gruvbox-material',
    config = config.gruvbox_material
  }
  use {
    'mbbill/undotree'
  }
  use { -- show git status
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = config.gitsigns
  }
  use {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
    opt = true,
    ft = 'markdown'
  }
  use { -- display detected color
    'norcalli/nvim-colorizer.lua',
    opt = true,
    cmd = 'ColorizerToggle',
    config = config.nvim_colorizer
  }
  use 'junegunn/vim-easy-align'
  use {
    'mhartington/formatter.nvim',
    opt = true,
    config = config.format,
    cmd = 'Format'
  }
  use { -- comment code quickly
    'numToStr/Comment.nvim',
    config = config.Comment
  }
  use { -- explore files
    'kyazdani42/nvim-tree.lua',
    config = config.nvim_tree,
    cmd = {'NvimTreeToggle', 'NvimTreeOpen'},
    requires = {'kyazdani42/nvim-web-devicons'}
  }
  use { -- search files
    'nvim-telescope/telescope.nvim',
    opt = true,
    cmd = 'Telescope',
    config = config.telescope,
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim'
    }
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
      'L3MON4D3/LuaSnip', -- snippets completion engine for nvim-cmp
      { -- tabnine source for nvim-cmp
        'tzachar/cmp-tabnine',
        run = './install.sh',
        requires = 'hrsh7th/nvim-cmp'
      }
    },
    config = config.nvim_cmp
  }
  use {
    'windwp/nvim-autopairs',
    config = config.nvim_autopairs
  }
  use {
      'williamboman/mason.nvim',
      config = config.mason
  }
  use { -- native lsp client config
    'neovim/nvim-lspconfig',
    after = 'cmp-nvim-lsp',
    config = config.lspconfig
  }
end)

local noremap = function (mode, key, mapped) vim.keymap.set(mode, key, mapped, {noremap = true}) end
local silnoremap = function (mode, key, mapped) vim.keymap.set(mode, key, mapped, {noremap = true, silent = true}) end
-- colorizer
silnoremap('n', '<leader>c', ':ColorizerToggle<CR>')

-- vim-easy-align
noremap('x', '<leader>al', ':EasyAlign<CR>')
noremap('n', '<leader>al', ':EasyAlign<CR>')

-- telescope
noremap('n', '<leader>ff', ':Telescope find_files<CR>')
noremap('n', '<leader>fg', ':Telescope live_grep<CR>')
noremap('n', '<leader>fb', ':Telescope buffers<CR>')
noremap('n', '<leader>fh', ':Telescope help_tags<CR>')

-- nvim-tree
silnoremap('n', '<leader>v', ':NvimTreeToggle<CR>')

-- undotree
silnoremap('n', '<leader>u', ':UndotreeToggle<CR>:UndotreeFocus<CR>')
