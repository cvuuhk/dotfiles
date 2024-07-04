local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath, })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "itchyny/vim-cursorword"
    },
    {
        "kyazdani42/nvim-web-devicons",
        lazy = true
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {"rust", "lua", "toml", "c", "cpp", "bash", "yaml", "json", "make", "python"},
                highlight = {
                    enable = true
                }
            })
        end
    },
    -- {
    --     "olimorris/onedarkpro.nvim",
    --     priority = 1000, -- Ensure it loads first
    --     config = function()
    --         require("onedarkpro").setup({
    --             options = {
    --                 transparency = true
    --             }
    --         })
    --         vim.cmd("colorscheme onedark")
    --     end
    -- },
    {
        "sainnhe/gruvbox-material",
        lazy = false,
        config = function()
            vim.g.gruvbox_material_transparent_background = 1
            -- vim.g.gruvbox_material_disable_italic_comment = 1
            vim.cmd("colorscheme gruvbox-material")
            vim.cmd('hi TelescopeSelection guifg=#282828 guibg=#d4be98')
            vim.cmd('hi TelescopeMatching guifg=#ea6962')
            vim.cmd('hi FloatBorder guibg=NONE')
            vim.cmd('hi StatusLine guibg=NONE')
        end
    },
    {
        "mbbill/undotree"
    },
    -- {
    --     'lewis6991/gitsigns.nvim',
    --     dependencies = { "nvim-lua/plenary.nvim" },
    --     config = function()
    --         require("gitsigns").setup({
    --             signs = {
    --                 add = {
    --                     hl = "GitSignsAdd",
    --                     text = "│",
    --                     numhl = "GitSignsAddNr",
    --                     linehl = "GitSignsAddLn"
    --                 },
    --                 change = {
    --                     hl = "GitSignsChange",
    --                     text = "│",
    --                     numhl = "GitSignsChangeNr",
    --                     linehl = "GitSignsChangeLn"
    --                 },
    --                 delete = {
    --                     hl = "GitSignsDelete",
    --                     text = "_",
    --                     numhl = "GitSignsDeleteNr",
    --                     linehl = "GitSignsDeleteLn"
    --                 },
    --                 topdelete = {
    --                     hl = "GitSignsDelete",
    --                     text = "‾",
    --                     numhl = "GitSignsDeleteNr",
    --                     linehl = "GitSignsDeleteLn"
    --                 },
    --                 changedelete = {
    --                     hl = "GitSignsChange",
    --                     text = "~",
    --                     numhl = "GitSignsChangeNr",
    --                     linehl = "GitSignsChangeLn"
    --                 }
    --             },
    --             numhl = true
    --         })
    --     end
    -- },
    {
        "iamcco/markdown-preview.nvim",
        lazy = true,
        ft = "markdown",
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    {
        'norcalli/nvim-colorizer.lua',
        lazy = true,
        cmd = "ColorizerToggle",
        config = function()
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
    },
    {
        'junegunn/vim-easy-align'
    },
    {
        'mhartington/formatter.nvim',
        lazy = true,
        cmd = "Format",
        config = function()
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
    },
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({
                ---Add a space b/w comment and the line
                padding = true,
                ---Whether the cursor should stay at its position
                ---NOTE: This only affects NORMAL mode mappings and doesn't work with dot-repeat
                sticky = true,
                ---Lines to be ignored while comment/uncomment.
                ---Could be a regex string or a function that returns a regex string.
                ---Example: Use '^$' to ignore empty lines
                ignore = '^$',
                ---LHS of toggle mappings in NORMAL + VISUAL mode
                toggler = {
                    ---Line-comment toggle keymap
                    line = 'gcc',
                    ---Block-comment toggle keymap
                    block = 'gbc'
                },
                ---LHS of operator-pending mappings in NORMAL + VISUAL mode
                opleader = {
                    ---Line-comment keymap
                    line = 'gc',
                    ---Block-comment keymap
                    block = 'gb'
                },
                ---LHS of extra mappings
                extra = {
                    ---Add comment on the line above
                    above = 'gcO',
                    ---Add comment on the line below
                    below = 'gco',
                    ---Add comment at the end of line
                    eol = 'gcA'
                },
                ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
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
                pre_hook = nil,
                post_hook = nil
            })
        end
    },
    {
        'kyazdani42/nvim-tree.lua',
        cmd = { "NvimTreeToggle", "NvimTreeOpen" },
        config = function()
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
    },
    {
        'nvim-telescope/telescope.nvim',
        lazy = true,
        cmd = 'Telescope',
        dependencies = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
        config = function()
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
    },

    {
        'hrsh7th/nvim-cmp', -- Autocompletion plugin
        dependencies = {
            'hrsh7th/cmp-buffer', -- buffer source for nvim-cmp
            'hrsh7th/cmp-path', -- path source for nvim-cmp
            'hrsh7th/cmp-nvim-lua', -- lua source for nvim-cmp
            'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
            'saadparwaiz1/cmp_luasnip', -- luasnip source for nvim-cmp
            { -- snippets completion engine for nvim-cmp
                'L3MON4D3/LuaSnip',
                -- follow latest release.
                version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
                -- install jsregexp (optional!).
                build = 'make install_jsregexp'
            },
            { -- tabnine source for nvim-cmp
                'tzachar/cmp-tabnine',
                build = './install.sh',
            }
        },
        config = function()
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
                completion = { completeopt = 'menu,menuone,noinsert' },
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
                    ['<CR>'] = cmp.mapping.confirm({select = true}),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
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
                        if luasnip.jumpable(1) then
                            luasnip.jump(1)
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
                    {name = 'buffer'},
                    {name = 'nvim_lsp'},
                    {name = 'path'},
                    {name = 'luasnip'},
                    {name = 'nvim_lua'},
                    {name = 'cmp_tabnine'}
                })
            })
            require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
        end
    },
    {
        'windwp/nvim-autopairs',
        config = function()
            local npairs = require('nvim-autopairs')
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")

            npairs.setup {
                disable_in_macro = true,
                disable_in_visualblock = true,
            }

            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({map_char = {tex = ""}}))

            npairs.remove_rule("`")
            npairs.remove_rule("```")
        end
    },
    {
        'williamboman/mason.nvim',
        config = function()
            require("mason").setup()
        end
    },
    {
        'neovim/nvim-lspconfig',
        config = function()
            vim.lsp.handlers['textDocument/publishDiagnostics'] =
            vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
                virtual_text = true,
                signs = true,
                underline = false,
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
                            globals = {"vim", "client", "awesome", "root", "screen"}
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

            local servers = {'bashls', 'ccls', 'cmake', 'pyright', 'rust_analyzer'}
            for _, lsp in ipairs(servers) do
                lspconfig[lsp].setup ({capabilities = capabilities})
            end
        end
    }
})

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
