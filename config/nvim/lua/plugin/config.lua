local config = {}

function config.gruvbox_flat()
  vim.g.gruvbox_transparent = true
  vim.g.gruvbox_italic_keywords = false
  vim.g.gruvbox_dark_sidebar = false
  vim.cmd [[colorscheme gruvbox-flat]]
end

function config.edge()
  vim.o.background = 'light'
  vim.cmd [[colorscheme edge]]
end

function config.nvim_treesitter()
  require("nvim-treesitter.configs").setup({
    -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = {"rust", "lua", "toml", "c", "cpp", "bash", "yaml"},
    ignore_install = {
      "Godot", "beancount", "bibtex", "c_sharp", "clojure", "comment", "commonlisp", "cuda",
      "dart", "devicetree", "elixir", "erlang", "fennel", "glimmer", "go", "graphql", "java",
      "javascript", "jsdoc", "julia", "kotlin", "ledger", "nix", "ocaml", "ocaml_interface",
      "php", "ql", "query", "r", "rst", "ruby", "scss", "sparql", "supercollider", "svelte",
      "teal", "tsx", "turtle", "typescript", "verilog", "vue", "zig"
    }, -- List of parsers to ignore installing
    highlight = {
      enable = true, -- false will disable the whole extension
      disable = {} -- list of language that will be disabled
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
      rust = {function() return {exe = "rustfmt", stdin = true} end},
      json = {
        function()
          return {
            exe = "json-glib-format -p",
            args = {vim.api.nvim_buf_get_name(0)},
            stdin = true
          }
        end
      }
    }
  })

end
function config.symbols_outline()
  -- init.lua
  vim.g.symbols_outline = {
    highlight_hovered_item = true,
    show_guides = true,
    auto_preview = true,
    position = 'right',
    relative_width = true,
    width = 40,
    auto_close = false,
    show_numbers = false,
    show_relative_numbers = false,
    show_symbol_details = true,
    preview_bg_highlight = 'Pmenu',
    keymaps = { -- These keymaps can be a string or a table for multiple keys
    close = {"<Esc>", "q"},
    goto_location = "<Cr>",
    focus_location = "o",
    hover_symbol = "<C-space>",
    toggle_preview = "K",
    rename_symbol = "r",
    code_actions = "a"
  },
  lsp_blacklist = {},
  symbol_blacklist = {},
  symbols = {
    File = {icon = "", hl = "TSURI"},
    Module = {icon = "", hl = "TSNamespace"},
    Namespace = {icon = "", hl = "TSNamespace"},
    Package = {icon = "", hl = "TSNamespace"},
    Class = {icon = "𝓒", hl = "TSType"},
    Method = {icon = "ƒ", hl = "TSMethod"},
    Property = {icon = "", hl = "TSMethod"},
    Field = {icon = "", hl = "TSField"},
    Constructor = {icon = "", hl = "TSConstructor"},
    Enum = {icon = "ℰ", hl = "TSType"},
    Interface = {icon = "ﰮ", hl = "TSType"},
    Function = {icon = "", hl = "TSFunction"},
    Variable = {icon = "", hl = "TSConstant"},
    Constant = {icon = "", hl = "TSConstant"},
    String = {icon = "𝓐", hl = "TSString"},
    Number = {icon = "#", hl = "TSNumber"},
    Boolean = {icon = "⊨", hl = "TSBoolean"},
    Array = {icon = "", hl = "TSConstant"},
    Object = {icon = "⦿", hl = "TSType"},
    Key = {icon = "🔐", hl = "TSType"},
    Null = {icon = "NULL", hl = "TSType"},
    EnumMember = {icon = "", hl = "TSField"},
    Struct = {icon = "𝓢", hl = "TSType"},
    Event = {icon = "🗲", hl = "TSType"},
    Operator = {icon = "+", hl = "TSOperator"},
    TypeParameter = {icon = "𝙏", hl = "TSParameter"}
  }
}
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

function config.hop() require'hop'.setup() end

function config.nvim_tree()
  require'nvim-tree'.setup {
    update_cwd = true,
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
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and
    vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") ==
    nil
  end

  cmp.setup({
    snippet = {expand = function(args) require('luasnip').lsp_expand(args.body) end},
    formatting = {
      format = function(entry, vim_item)
        -- Kind icons
        vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
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
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, {"i", "s"}),
      ['<C-p>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {"i", "s"})
    },
    sources = cmp.config.sources({
      {name = 'nvim_lsp'}, --
      {name = 'path'}, --
      {name = 'buffer'}, --
      {name = 'luasnip'}, --
      {name = 'nvim_lua'}, --
      {name = 'cmp_tabnine'} --
    })
  })
end

function config.nvim_autopairs()
  local npairs = require('nvim-autopairs')
  local Rule = require('nvim-autopairs.rule')
  local cond = require('nvim-autopairs.conds')
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  local cmp = require("cmp")

  npairs.setup {
    disable_in_macro = true,
    disable_in_visualblock = true,
  }

  npairs.add_rule(Rule("`", "`", "markdown"):with_pair(cond.none()))

  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({map_char = {tex = ""}}))
end

function config.lspconfig()
  vim.lsp.handlers['textDocument/publishDiagnostics'] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false
  })
  local lspconfig = require("lspconfig")
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
  lspconfig.sumneko_lua.setup({
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

  -- config.clangd.setup {capabilities = capabilities}
  local servers = {'clangd', 'rust_analyzer', 'bashls', 'pyright'}
  for _, lsp in ipairs(servers) do lspconfig[lsp].setup {capabilities = capabilities} end
end

return config
