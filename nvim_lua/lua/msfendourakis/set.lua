local set = vim.opt
vim.g.mapleader = " "

set.guicursor = ""
set.mouse = ""
set.number = true
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 0
set.expandtab = true
set.relativenumber = true
set.hidden = true
set.tabstop=2 
set.softtabstop=2
set.shiftwidth=2
set.expandtab = true
set.smartindent = true
set.nu = true
set.wrap = false
set.smartcase = true
set.swapfile = false
set.undodir="/home/msfendourakis/.vim/undodir" -- TODO dynamically set $HOME
set.undofile = true
set.hlsearch = false
set.incsearch = true
set.linebreak = true
set.title = true -- change the terminal's title
set.smartcase = true -- search will be case sensitive if it contains an uppercase letter
set.ignorecase = true -- smartcase also needs ignorecase
-- Give more space for displaying messages.
set.cmdheight=2
-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
set.updatetime=50
-- Don't pass messages to |ins-completion-menu|.
set.colorcolumn="120"
-- highlight ColorColumn ctermbg=0 guibg=lightgrey

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-f>', builtin.find_files, { noremap = true })
vim.keymap.set('n', '<leader>rg', builtin.live_grep, { noremap = true })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { noremap = true })

-- open a new tmux window in split mode in the same dir with the buffer
vim.keymap.set('n', '<leader>o', function () os.execute("tmux splitw -h -c" ..  vim.fn.expand '%:p:h' .. '/') end, { expr = true })


-- lualine
require('lualine').setup{
  options = {
    theme = 'papercolor_dark'
  }
}
