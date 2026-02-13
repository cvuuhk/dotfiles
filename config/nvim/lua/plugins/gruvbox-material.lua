return {
  "sainnhe/gruvbox-material",
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.gruvbox_material_transparent_background = 1
    vim.g.gruvbox_material_disable_italic_comment = 1
    vim.cmd("colorscheme gruvbox-material")

    -- neovim
    vim.cmd('hi FloatBorder guibg=NONE')
    vim.cmd('hi NormalFloat guibg=NONE')

    -- telescope
    vim.cmd('hi TelescopeSelection guifg=#282828 guibg=#d4be98')
    vim.cmd('hi TelescopeMatching guifg=#ea6962')

    -- blink.cmp
    vim.cmd('hi Pmenu guibg=NONE')
    vim.cmd('hi PmenuExtra guibg=NONE')
  end
}
