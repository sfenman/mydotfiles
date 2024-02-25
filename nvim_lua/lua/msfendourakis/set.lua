local set = vim.opt
vim.g.mapleader = " "
-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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
set.hlsearch = true
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

-- empty setup using defaults
require("nvim-tree").setup()
vim.keymap.set('n', '<leader>nt', '<cmd>NvimTreeToggle<CR>', { noremap = true })


local telescope = require('telescope')

telescope.setup {
  pickers = {
    find_files = {
      hidden = true
    }
  }
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-f>', builtin.find_files, { noremap = true })
vim.keymap.set('n', '<leader>rg', builtin.live_grep, { noremap = true })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { noremap = true })

-- open a new tmux window in split mode in the same dir with the buffer
vim.keymap.set('n', '<leader>o', function () os.execute("tmux splitw -h -c" ..  vim.fn.expand '%:p:h' .. '/') end, { expr = true })


-- lualine
require('lualine').setup{
  options = {
    theme = 'tokyonight'
  },
  sections = {
    lualine_a = {
      {
        'filename',
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
      }
    }
  }
}

-- comment nvim
require('Comment').setup()

-- treesitter
require'nvim-treesitter.configs'.setup {
    sync_install = false,
    ensure_installed = { "go" },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

-- setup Native LSP
-- install GOPLS (or any language server I want)
-- Use Fullpath of GOPLS
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require'lspconfig'.gopls.setup{
  capabilities = capabilities,
  on_attach = function()
--    vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0}) -- buffer=0 means use this only for the current buffer
--  vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
--  vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, {buffer=0})
--  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer=0})
--  vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, {buffer=0})
--  vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, {buffer=0})
    vim.keymap.set("n", "<leader>dg", "<cmd>Telescope diagnostics<cr>", {buffer=0}) -- opens telescope with all the errors of a project
    vim.keymap.set("n", "<leader>rf", "<cmd>Telescope lsp_references<cr>", {buffer=0}) -- opens telescope with all the references of the object undor cursor
--  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {buffer=0}) -- rename variable under cursor
  end,
} -- connecto to the server
-- go format on save
vim.cmd([[autocmd BufWritePre *.go lua vim.lsp.buf.formatting()]])


-- Pyright setup
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

-- Terraform setup
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
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
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


-- hcl format on save
vim.cmd([[let g:terraform_fmt_on_save=1]])
vim.cmd([[let g:terraform_align=1]])
vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tf]])
vim.cmd([[autocmd BufRead,BufNewFile *.hcl set filetype=terraform]]) -- filetype=terraform required for hclfmt on save
vim.cmd([[autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform]])
vim.cmd([[autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json]])

-- TODO: Do it with lua in config instead inside the plugin
--" Added the following into the vim-terraform plugin on ftpplugin/hcl.vim file
--  For packer is ~/.local/share/nvim/site/pack/packer/start/
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

-- Move up/down editor lines
vim.keymap.set('n', 'j', 'gj', opts)
vim.keymap.set('n', 'k', 'gk', opts)

------------- LSP SAGA -----------
local keymap = vim.keymap.set

local saga = require('lspsaga').setup({
   definition = {
     edit = '<CR>',
     vsplit = '<leader>v',
     split = '<leader>s',
     tabe = '<C-c>t',
     quit = 'q',
   },
   finder = {
     open = {'o', '<CR>'},
     vsplit = '<leader>v',
     split = '<leader>s',
     tabe = '<C-c>t',
     quit = {'q', '<ESC>'},
  },
})

-- Lsp finder find the symbol definition implement reference
-- if there is no implement it will hide
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

-- Code action
keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })

-- Rename
keymap("n", "gr", "<cmd>Lspsaga rename<CR>", { silent = true })

-- Peek Definition
-- you can edit the definition file in this flaotwindow
-- also support open/vsplit/etc operation check definition_action_keys
-- support tagstack C-t jump back
keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })

-- Show line diagnostics
keymap("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

-- Show cursor diagnostic
-- keymap("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })

-- Diagnsotic jump can use `<c-o>` to jump back
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

-- Only jump to error
keymap("n", "[E", function()
  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
keymap("n", "]E", function()
  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })

-- Outline
keymap("n","<leader>to", "<cmd>LSoutlineToggle<CR>",{ silent = true })

-- Hover Doc
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

-- Float terminal
-- if you want pass somc cli command into terminal you can do like this
-- open lazygit in lspsaga float terminal
keymap("n", "<A-d>", "<cmd>Lspsaga term_toggle lazygit<CR>", { silent = true })
-- close floaterm
keymap("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga term_toggle<CR>]], { silent = true })

-- Indentation

-- Indentation
-- Deletes EOL blank lines
vim.api.nvim_create_autocmd('BufWritePre', {command = '%s/\\s\\+$//e'})
-- Shows · on EOL
vim.opt.list = true
vim.opt.listchars:append "eol:·"

require("ibl").setup()

-- clear highlighting
vim.keymap.set('n', '<ESC>', '<Cmd>noh<CR>', opts)

-- -- helm - ls config
-- local configs = require('lspconfig.configs')
-- local lspconfig = require('lspconfig')
-- local util = require('lspconfig.util')
--
-- if not configs.helm_ls then
--   configs.helm_ls = {
--     default_config = {
--       cmd = {"helm_ls", "serve"},
--       filetypes = {'helm'},
--       root_dir = function(fname)
--         return util.root_pattern('Chart.yaml')(fname)
--       end,
--     },
--   }
-- end
--
-- lspconfig.helm_ls.setup {
--   filetypes = {"helm"},
--   cmd = {"helm_ls", "serve"},
-- }
