local config = {}

function config.symbol_outline()
  require("symbols-outline").setup()
end

function config.gruvbox_material()
  vim.g.gruvbox_material_transparent_background = 1
  -- vim.g.gruvbox_material_disable_italic_comment = 1
  vim.cmd("colorscheme gruvbox-material")
  vim.cmd('hi TelescopeSelection guifg=#282828 guibg=#d4be98')
  vim.cmd('hi TelescopeMatching guifg=#ea6962')
  vim.cmd('hi FloatBorder guibg=NONE')
  vim.cmd('hi StatusLine guibg=NONE')
end

function config.nvim_treesitter()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {"rust", "lua", "toml", "c", "cpp", "bash", "yaml", "json", "make", "python"},
    highlight = {
      enable = true
    }
  })
end

function config.gitsigns()
  require("gitsigns").setup({
    signs = {
        add = {
          hl = "GitSignsAdd",
          text = "│",
          numhl = "GitSignsAddNr",
          linehl = "GitSignsAddLn"
        },
        change = {
          hl = "GitSignsChange",
          text = "│",
          numhl = "GitSignsChangeNr",
          linehl = "GitSignsChangeLn"
        },
        delete = {
          hl = "GitSignsDelete",
          text = "_",
          numhl = "GitSignsDeleteNr",
          linehl = "GitSignsDeleteLn"
        },
        topdelete = {
          hl = "GitSignsDelete",
          text = "‾",
          numhl = "GitSignsDeleteNr",
          linehl = "GitSignsDeleteLn"
        },
        changedelete = {
          hl = "GitSignsChange",
          text = "~",
          numhl = "GitSignsChangeNr",
          linehl = "GitSignsChangeLn"
        }
    },
    numhl = true
  })
end

function config.nvim_colorizer()
  require'colorizer'.setup({'*'}, {
    RGB = false, -- #RGB hex codes
    RRGGBB = true, -- #RRGGBB hex codes
    names = false, -- "Name" codes like Blue
    RRGGBBAA = false, -- #RRGGBBAA hex codes
    rgb_fn = false, -- CSS rgb() and rgba() functions
    hsl_fn = false, -- CSS hsl() and hsla() functions
    css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
    -- Available modes: foreground, background
    mode = 'background' -- Set the display mode.
  })
end

function config.format()
  require("formatter").setup({
    filetype = {
      rust = function() return {exe = "rustfmt", stdin = true} end,
      json = function()
        return {
          exe = "jq",
          -- args = {vim.api.nvim_buf_get_name(0)},
          stdin = true
        }
      end,
      ["*"] = {
        require("formatter.filetypes.any").remove_trailing_whitespace
      }
    }
  })
end

function config.Comment()
  require('Comment').setup({
    ---Add a space b/w comment and the line
    ---@type boolean
    padding = true,

    ---Whether the cursor should stay at its position
    ---NOTE: This only affects NORMAL mode mappings and doesn't work with dot-repeat
    ---@type boolean
    sticky = true,

    ---Lines to be ignored while comment/uncomment.
    ---Could be a regex string or a function that returns a regex string.
    ---Example: Use '^$' to ignore empty lines
    ---@type string|fun():string
    ignore = '^$',

    ---LHS of toggle mappings in NORMAL + VISUAL mode
    ---@type table
    toggler = {
      ---Line-comment toggle keymap
      line = 'gcc',
      ---Block-comment toggle keymap
      block = 'gbc'
    },

    ---LHS of operator-pending mappings in NORMAL + VISUAL mode
    ---@type table
    opleader = {
      ---Line-comment keymap
      line = 'gc',
      ---Block-comment keymap
      block = 'gb'
    },

    ---LHS of extra mappings
    ---@type table
    extra = {
      ---Add comment on the line above
      above = 'gcO',
      ---Add comment on the line below
      below = 'gco',
      ---Add comment at the end of line
      eol = 'gcA'
    },

    ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
    ---@type table
    mappings = {
      ---Operator-pending mapping
      ---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
      ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
      basic = true,
      ---Extra mapping
      ---Includes `gco`, `gcO`, `gcA`
      extra = true,
      ---Extended mapping
      ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
      extended = false
    },

    ---Pre-hook, called before commenting the line
    ---@type fun(ctx: Ctx):string
    pre_hook = nil,

    ---Post-hook, called after commenting is done
    ---@type fun(ctx: Ctx)
    post_hook = nil
  })
end

function config.nvim_tree()
  -- 自动关闭最后一个 nvim-tree 窗口
  vim.cmd([[autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]])
  require'nvim-tree'.setup {
    view = {
      side = 'right',
      width = 40
    },
    actions = {
      open_file = {
        quit_on_open = true
      }
    },
    renderer = {
      indent_markers = {
        enable = true,
        inline_arrows = false,
        icons = {
          corner = "└",
          edge = "│",
          item = "│",
          none = " ",
        },
      },
      icons = {
        webdev_colors = true,
        show = {
          folder_arrow = false
        }
      },
    }
  }
end

function config.telescope()
  require("telescope").setup({
    defaults = {
      vimgrep_arguments = {
        "rg", "--color=never", "--no-heading", "--with-filename", "--line-number",
        "--column", "--smart-case"
      },
      prompt_prefix = "> ",
      selection_caret = "> ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "descending",
      layout_strategy = "horizontal",
      layout_config = {horizontal = {mirror = false}, vertical = {mirror = false}},
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      file_ignore_patterns = {"undodir"},
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      winblend = 0,
      border = {},
      borderchars = {'─', '│', '─', '│', '┌', '┐', '┘', '└'},
      -- borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      -- borderchars = {"-", "|", "-", "|", "+", "+", "+", "+"},
      color_devicons = true,
      use_less = true,
      set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker
    }
  })
end

function config.nvim_cmp()
  vim.o.completeopt = 'menu,menuone,noselect'
  local kind_icons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = ""
  }
  local cmp = require('cmp')
  local luasnip = require("luasnip")

  cmp.setup({
    snippet = {expand = function(args) require('luasnip').lsp_expand(args.body) end},
    formatting = {
      format = function(entry, vim_item)
        -- This concatonates the icons with the name of the item kind
        vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
        -- Source
        vim_item.menu = ({
          path = "[Path]",
          buffer = "[Buffer]",
          luasnip = "[LuaSnip]",
          nvim_lsp = "[LSP]",
          nvim_lua = "[Lua]",
          cmp_tabnine = "[TabNine]"
        })[entry.source.name]
        return vim_item
      end
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(4),
      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<CR>'] = cmp.mapping.confirm({select = false}),
      ['<C-n>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end, {"i", "s"}),
      ['<C-p>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, {"i", "s"}),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, {"i", "s"}),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {"i", "s"})
    },
    sources = cmp.config.sources({
      {name = 'nvim_lsp'},
      {name = 'path'},
      {name = 'buffer'},
      {name = 'luasnip'},
      {name = 'nvim_lua'},
      {name = 'cmp_tabnine'}
    })
  })
  require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
end

function config.nvim_autopairs()
  local npairs = require('nvim-autopairs')
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  local cmp = require("cmp")

  npairs.setup {
    disable_in_macro = true,
    disable_in_visualblock = true,
  }

  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({map_char = {tex = ""}}))

  local Rule = require('nvim-autopairs.rule')

  npairs.remove_rule("`")
  npairs.remove_rule("```")
end

function config.mason()
    require("mason").setup()
end

function config.mason_lspconfig()
    require("mason-lspconfig").setup {
        ensure_installed = {
            "bashls",
            "clangd",
            "lua_ls",
            "pyright",
            "rust_analyzer",
            "yamlls"
        }
    }
end

function config.lspconfig()
  vim.lsp.handlers['textDocument/publishDiagnostics'] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false
  })
  local lspconfig = require("lspconfig")
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
  lspconfig.lua_ls.setup({
    cmd = {"lua-language-server"},
    settings = {
      Lua = {
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {"vim"}
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true)
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {enable = false}
      }
    }
  })

  local servers = {'bashls', 'clangd', 'lua_ls', 'pyright', 'rust_analyzer', 'yamlls'}
  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup ({capabilities = capabilities})
  end
end

return config
