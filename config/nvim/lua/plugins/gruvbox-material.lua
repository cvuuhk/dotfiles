return {
  "sainnhe/gruvbox-material",
  lazy = false,
  config = function()
    vim.g.gruvbox_material_transparent_background = 1
    vim.g.gruvbox_material_disable_italic_comment = 1
    vim.cmd("colorscheme gruvbox-material")
    vim.cmd('hi TelescopeSelection guifg=#282828 guibg=#d4be98')
    vim.cmd('hi TelescopeMatching guifg=#ea6962')
    -- vim.cmd('hi FloatBorder guibg=NONE')
    -- vim.cmd('hi StatusLine guibg=NONE')

    vim.cmd('hi Pmenu guibg=NONE')
    vim.cmd('hi PmenuExtra guibg=NONE')
  end
}
