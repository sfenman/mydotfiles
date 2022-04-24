syntax on

set relativenumber
set hidden
set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nu
" set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set linebreak
set title " change the terminal's title
"
" Give more space for displaying messages.
set cmdheight=2
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set colorcolumn=120
highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin('~/.config/nvim/plugged')

Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'mbbill/undotree'
Plug 'ekalinin/Dockerfile.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Raimondi/delimitMate'
Plug 'christoomey/vim-tmux-navigator'
Plug 'hashivim/vim-terraform'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'qpkorr/vim-bufkill'
Plug 'Yggdroot/indentLine'
Plug 'pedrohdz/vim-yaml-folds'
Plug 'preservim/vimux'

" coloreschemes
Plug 'rakr/vim-one'
Plug 'NLKNguyen/papercolor-theme'
Plug 'dracula/vim'
Plug 'colepeters/spacemacs-theme.vim'
Plug 'sainnhe/gruvbox-material'

call plug#end()


if (has("termguicolors"))
  set termguicolors
endif
set background=dark
let g:gruvbox_material_background = 'hard'
colorscheme gruvbox-material

let g:airline_theme = 'one'


let mapleader = " "

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25



" Vertical Split
nnoremap <leader>v :vsplit<CR>
" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim
" tab and shift+tab to move between buffers
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

" close current buffer without closing the window (bufkill plugin)
nnoremap <leader>q :BD<cr>

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

"vim go settings
autocmd BufWritePre *.go :GoImports
" vim airline settings
let g:airline#extensions#tabline#enabled = 1
" show dir/filename in tabs
let g:airline#extensions#tabline#formatter = 'short_path'

" fzf settings
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'
nnoremap <silent> <C-f> :Files<CR>

let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-h': 'split',
    \ 'ctrl-v': 'vsplit' }

" search history
nmap <silent> <leader>h :History<cr>

" search across git files
nnoremap <silent> <leader>gf :GFiles<cr>
" search open buffers
nnoremap <silent> <leader>b :Buffers<cr>
" ripgrep with fzf
nnoremap <silent> <leader>rg :Rg<cr>

" git fugitive
nnoremap <leader>gb :GBranches<CR>
nnoremap <leader>gd :Gdiffsplit<CR>

" markdown live preview
nnoremap <leader>lp :MarkdownPreview<CR>
nnoremap <leader>lps :MarkdownPreviewStop<CR>

" undotree
nnoremap <leader>ut :UndotreeToggle<CR>
" move between buffers
noremap <leader>h <C-w>h
noremap <leader>j <C-w>j
noremap <leader>k <C-w>k
noremap <leader>l <C-w>l
noremap <leader>w <C-w>w

" terraform syntax highlighting to .hcl(for terragrunt only) files
autocmd BufRead,BufNewFile *.hcl set filetype=terraform
" terraform fmt on save
let g:terraform_fmt_on_save=1

" Added the following into the vim-terraform plugin on ftpplugin directory
" to support formatting into hcl files with terraform fmt
"
"if get(g:, 'terraform_fmt_on_save', 0)
"  augroup vim.terraform.fmt
"    autocmd!
"   autocmd BufWritePre *.tf call terraform#fmt()
"    autocmd BufWritePre *.hcl call terraform#fmt()
"    autocmd BufWritePre *.tfvars call terraform#fmt()
"  augroup END
"endif
"coc vim autocomplete with tab
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P


" clear highlighting
nnoremap <nowait><silent> <ESC> :noh<CR>

" disable yaml-folds plugin folding all blocks by default
set foldlevelstart=20

" Prompt tmux pane to run command
nnoremap <Leader>rc :VimuxPromptCommand<CR>
