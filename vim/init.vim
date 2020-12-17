let mapleader = "\<Space>"

" ============================================================
" PLUGINS

function! Cond(Cond, ...)
  let opts = get(a:000, 0, {})
  return a:Cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" Load plugins
call plug#begin('~/AppData/Local/nvim/plugged')

" Use different easymotion plugins for actual vim and vscode
" Plug 'asvetliakov/vim-easymotion', Cond(exists('g:vscode'), { 'as': 'vsc-easymotion' })
" Plug 'easymotion/vim-easymotion', Cond(!exists('g:vscode'))

" Vim Enhancements
Plug 'christoomey/vim-sort-motion'
Plug 'justinmk/vim-sneak'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'xolox/vim-misc' " Needed for vim-session
Plug 'xolox/vim-session'

" GUI Enhancements
Plug 'itchyny/lightline.vim'
Plug 'liuchengxu/vim-which-key'
Plug 'machakann/vim-highlightedyank'
Plug 'nathanaelkane/vim-indent-guides'

" Themes
Plug 'joshdick/onedark.vim'

" Fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', { 'commit': '3c07232' }
Plug 'nvim-treesitter/playground'

" Language support
Plug 'neoclide/coc.nvim'

call plug#end()

" Completion
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" Startify settings
let g:startify_lists = [
      \ { 'type': 'bookmarks' },
      \ { 'type': 'files', 'header': ['   MRU:'] },
      \ ]
let g:startify_bookmarks = [
      \ {'a': 'c:/Files/Development'},
      \ {'y': 'c:/Users/Caleb/AppData/Roaming/alacritty/alacritty.yml'},
      \ {'z': 'c:/Users/Caleb/AppData/Local/nvim'},
      \ ]

" Don't save hidden and unloaded buffers in sessions.
set sessionoptions-=buffers

" ============================================================
" EDITOR SETTINGS

" Line numbers
set number
set relativenumber
filetype plugin on

" Color theme
" if (has("autocmd"))
"   augroup colorextend
"     autocmd!
"     " Override background color
"     let s:background = { "gui": "0x14151a", "cterm": "235", "cterm16": "0" }
"     autocmd ColorScheme * call onedark#set_highlight("Normal", { "bg": s:background }) "No `fg` setting
" endif
autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
set termguicolors
" Color theme
syntax on
colorscheme onedark
set background=dark
let g:lightline = {
      \  'colorscheme': 'onedark',
      \ }

" GUI settings
set noshowmode

" Enable indent guides by default
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#1d1f26   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#272933 ctermbg=4
" ============================================================
" KEYBOARD SETTINGS

" No arrow keys for you!
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Move code blocks
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Use <c-.> to trigger completion.
inoremap <silent><expr> <c-.> coc#refresh()

" Spaces > tabs
set expandtab
set shiftwidth=2
set softtabstop=2

" Better navigation hotkeys
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l

" Clear search with double search
noremap // :let @/=""<cr>

" Jump to start and end of line using the home row keys
map H ^
map L $

" Proper search
set incsearch
set ignorecase
set smartcase
set gdefault

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Move by line
nnoremap j gj
nnoremap k gk

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use <TAB> for selections ranges.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Find symbol of current document.
nnoremap <silent> \o  :<C-u>CocList outline<cr>

" Search workspace symbols.
nnoremap <silent> \s  :<C-u>CocList -I symbols<cr>

" Implement methods for trait
nnoremap <silent> \i  :call CocActionAsync('codeAction', '', 'Implement missing members')<cr>

" Show actions available at this location
nnoremap <silent> \a  :CocAction<cr>

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Project wide renaming
nnoremap <leader>prw :CocSearch <c-r>=expand("<cword>")<cr><cr>

" FZF shortcuts
nnoremap <leader>f :Files<cr>
nnoremap <leader>rr :Rg<cr>

" WhichKey
set timeoutlen=250
nnoremap <silent> <leader> :WhichKey ' '<CR>

" Startify shortcut
nnoremap <leader>1 :Startify<cr>

" Switch splits with ctrl-movement
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Use vim-sneak instead of built-in f and t
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" ============================================================
" OTHER

:lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- Modules and its options go here
  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
}
EOF

