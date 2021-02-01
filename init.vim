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
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'shime/vim-livedown'
Plug 'vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Raimondi/delimitMate'
Plug 'christoomey/vim-tmux-navigator'
Plug 'preservim/nerdtree'
Plug 'hashivim/vim-terraform'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

colorscheme gruvbox
set background=dark


let mapleader = " "

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25


set runtimepath^=~/.vim/plugged/ctrlp.vim

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

"vim go settings
autocmd BufWritePre *.go :GoImports

" vim airline settings
let g:airline#extensions#tabline#enabled = 1
" show dir/filename in tabs
let g:airline#extensions#tabline#formatter = 'short_path'

" nerdtree settings
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" nerdtree use leader + r to refresh directories instead of r inside nerdtree
nmap <Leader>r :NERDTreeFocus<cr>R<c-w><c-p>
nnoremap <Leader>n :NERDTreeToggle<CR>

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

" search across files in the current directory
nnoremap <C-p> :Files<cr>

" search across git files
nnoremap <silent> <leader>gf :GFiles<cr>

" search open buffers
nnoremap <silent> <leader>b :Buffers<cr>


" git fugitive
nnoremap <leader>gb :GBranches<CR>
nnoremap <leader>gd :Gdiffsplit<CR>

" markdown live preview
nnoremap <leader>lp :LivedownToggle<CR>

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
