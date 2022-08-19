vim.o.guifont = 'mono:h10'

function toggle_fullscreen() vim.cmd("let g:neovide_fullscreen = !g:neovide_fullscreen") end

local map = vim.api.nvim_set_keymap
map('n', '<F11>', ':lua toggle_fullscreen()<CR>', {noremap = true, silent = true})
