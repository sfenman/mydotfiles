local set = vim.opt
vim.g.mapleader = " "
local opts = { noremap = true, silent = true }

-- Move to previous/next

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
set.wrap = true
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
    theme = 'dracula'
  },
  sections = {
    lualine_a = {
      {
        'filename',
        file_status = true, -- displays file status (readonly status, modified status)
        path = 2 -- 0 = just filename, 1 = relative path, 2 = absolute path
      }
    }
  }
}

-- setup Native LSP
-- install GOPLS (or any language server I want)
-- Use Fullpath of GOPLS
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require'lspconfig'.gopls.setup{
  capabilities = capabilities,
  on_attach = function()
  vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0}) -- buffer=0 means use this only for the current buffer
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
  vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, {buffer=0})
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer=0})
  vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, {buffer=0})
  vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, {buffer=0})
  vim.keymap.set("n", "<leader>dg", "<cmd>Telescope diagnostics<cr>", {buffer=0}) -- opens telescope with all the errors of a project
  vim.keymap.set("n", "<leader>rf", "<cmd>Telescope lsp_references<cr>", {buffer=0}) -- opens telescope with all the references of the object undor cursor
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {buffer=0}) -- rename variable under cursor
  end,
 } -- connecto to the server

require'lspconfig'.pyright.setup{
  capabilities = capabilities,
  on_attach = function()
  vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0}) -- buffer=0 means use this only for the current buffer
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
  vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, {buffer=0})
  vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, {buffer=0})
  vim.keymap.set("n", "<leader>dg", "<cmd>Telescope diagnostics<cr>", {buffer=0}) -- opens telescope with all the errors of a project
  vim.keymap.set("n", "<leader>rf", "<cmd>Telescope lsp_references<cr>", {buffer=0}) -- opens telescope with all the references of the object undor cursor
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {buffer=0}) -- rename variable under cursor
  end,
 } -- connecto to the server

require'lspconfig'.terraformls.setup{
  filetypes = { "terraform", "hcl" }
}

require'lspconfig'.tflint.setup{
  filetypes = { "terraform", "hcl" }
}

-- Set up nvim-cmp.
set.completeopt={'menu','menuone','noselect'} -- required by vim
local cmp = require'cmp'

-- the order of sources matters in score for which result will come first
-- Configuration:
--    keyword_length
--    priority
--    max_item_count
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
    ['<C-n>'] = cmp.mapping.select_next_item(select_opts),
    ['<C-Y>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'luasnip' }, -- For luasnip users.
  }, {
    { name = 'path' },
    { name = 'buffer', keyword_length = 5 },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- hcl format on save
vim.cmd([[let g:terraform_fmt_on_save=1]])
vim.cmd([[let g:terraform_align=1]])
vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tf]])
vim.cmd([[autocmd BufRead,BufNewFile *.hcl set filetype=terraform]]) -- filetype=terraform required for hclfmt on save
vim.cmd([[autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform]])
vim.cmd([[autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json]])

-- TODO: Do it with lua in config instead inside the plugin
--" Added the following into the vim-terraform plugin on ftpplugin directory
--" to support formatting into hcl files with terraform fmt
--"
--"if get(g:, 'terraform_fmt_on_save', 0)
--"  augroup vim.terraform.fmt
--"    autocmd!
--"   autocmd BufWritePre *.tf call terraform#fmt()
--"    autocmd BufWritePre *.hcl call terraform#fmt()
--"    autocmd BufWritePre *.tfvars call terraform#fmt()
--"  augroup END
--"endif

-- Buffer showing on top
vim.opt.termguicolors = true
require("bufferline").setup{}

vim.keymap.set('n', '<A-,>', '<Cmd>bprev<CR>', opts)
vim.keymap.set('n', '<A-.>', '<Cmd>bnext<CR>', opts)
-- Close buffer
vim.keymap.set('n', '<leader>q', '<Cmd>bd<CR>', opts)


-- Copy to clipboard
vim.keymap.set('v', '<leader>y', '"+y', opts)
vim.keymap.set('n', '<leader>y', '"+y', opts)

-- Paste from clipboard
vim.keymap.set('v', '<leader>p', '"+p', opts)
vim.keymap.set('n', '<leader>p', '"+p', opts)

-- vertical split
vim.keymap.set('n', '<leader>v', '<Cmd>vsplit<CR>', opts)

-- move between windows
vim.keymap.set('n', '<leader>w', '<C-w>w', opts)

-- Neogit
local neogit = require('neogit')
neogit.setup {
  integrations = {
    diffview = true -- requires the sindrets/diffview plugin
  },
}
