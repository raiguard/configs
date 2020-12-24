let mapleader = "\<Space>"

" ============================================================
" PLUGINS

function! Cond(Cond, ...)
  let opts = get(a:000, 0, {})
  return a:Cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" Load plugins
call plug#begin('~/AppData/Local/nvim/plugged')

" Vim Enhancements
Plug 'Raimondi/delimitMate'
Plug 'christoomey/vim-sort-motion'
Plug 'idanarye/vim-merginal'
Plug 'justinmk/vim-sneak'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-user' " Required for textobj-entire
Plug 'mhinz/vim-startify'
Plug 'puremourning/vimspector'
Plug 'rbong/vim-flog' " Requires fugitive
Plug 'szw/vim-maximizer'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'

" Formatters
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

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
" Plug 'nvim-lua/popup.nvim'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'

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
      \ {'f': 'c:/Files/Development/Factorio/Mods'},
      \ {'z': 'c:/Files/Configs'},
      \ ]

" Python directory
let g:python3_host_prog = "c:/Files/Development/Python/.python/python.exe"

let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" Sneak
let g:sneak#label = 1

" Telescope
" :lua <<EOF
" require("telescope").setup{
"   defaults = {
"     vimgrep_arguments = {
"       'rg',
"       '--color=never',
"       '--no-heading',
"       '--with-filename',
"       '--line-number',
"       '--column',
"       '--smart-case'
"     },
"     prompt_position = "bottom",
"     prompt_prefix = ">",
"     selection_strategy = "reset",
"     sorting_strategy = "descending",
"     layout_strategy = "horizontal",
"     layout_defaults = {
"       -- TODO add builtin options.
"     },
"     file_sorter =  require'telescope.sorters'.get_fuzzy_file,
"     file_ignore_patterns = {},
"     generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
"     shorten_path = true,
"     winblend = 0,
"     width = 0.75,
"     preview_cutoff = 120,
"     results_height = 1,
"     results_width = 0.8,
"     border = {},
"     borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
"     color_devicons = true,
"     use_less = true,
"     set_env = { ['COLORTERM'] = 'truecolor' }, -- default { }, currently unsupported for shells like cmd.exe / powershell.exe
"     file_previewer = require'telescope.previewers'.cat.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_cat.new`
"     grep_previewer = require'telescope.previewers'.vimgrep.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_vimgrep.new`
"     qflist_previewer = require'telescope.previewers'.qflist.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_qflist.new`
"   }
" } 
" EOF

" ============================================================
" EDITOR SETTINGS

" Tab row
function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 5) . 'T'

    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  return s
endfunction

function! MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  return bufname(buflist[winnr - 1])
endfunction

set tabline=%!MyTabLine()

" Spaces > tabs
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smartindent
set autoindent

" Line numbers
set number
set relativenumber
filetype plugin on

" More natural splits
set splitbelow
set splitright

" Color theme
autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
set termguicolors
" Color theme
syntax on
colorscheme onedark
set background=dark

" GUI settings
set noshowmode

" Enable indent guides by default
if !exists('g:vscode')
  let g:indent_guides_enable_on_vim_startup = 1
endif
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#1d1f26   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#272933 ctermbg=4

" Auto-strip trailing whitespace
" function! <SID>StripTrailingWhitespaces()
"     let l = line(".")
"     let c = col(".")
"     %s/\s\+$//e
"     call cursor(l, c)
" endfun
" autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" FZF delete buffers command
function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
\ }))

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
" Movements centered please
nnoremap <silent> <c-o> <c-o>zz
nnoremap <silent> <c-i> <c-i>zz
nnoremap <expr> ' "'" . nr2char(getchar()) . "zz"
nnoremap <expr> ` "`" . nr2char(getchar()) . "zz"

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
nnoremap <leader>fb :Buffers<cr>
nnoremap <leader>ff :Files<cr>
nnoremap <leader>fg :Rg<cr>
nnoremap <leader>fd :BD<cr>

" " Telescope shortcuts
" nnoremap <leader>ff :Telescope find_files<cr>
" nnoremap <leader>fb :Telescope buffers<cr>
" nnoremap <leader>fg :Telescope live_grep<cr>

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

" Git (fugitive, merginal, Flog
nmap <leader>gs :G<cr>
nmap <leader>gb :Merginal<cr>
nmap <leader>gg :Flog<cr>
nmap <leader>gc :Gcommit<cr>:sleep 200m<cr><cr>
nmap <leader>gp :Gpush<cr>

" Avoid `press enter to continue` when comitting from GS
function! s:ftplugin_fugitive() abort
  nnoremap <buffer> <silent> cc :Git commit --quiet<CR>
  nnoremap <buffer> <silent> ca :Git commit --quiet --amend<CR>
  nnoremap <buffer> <silent> ce :Git commit --quiet --amend --no-edit<CR>
endfunction
augroup nhooyr_fugitive
  autocmd!
  autocmd FileType fugitive call s:ftplugin_fugitive()
augroup END

" Tabs and terminal
nmap <leader>tn :tabnew<cr>
nmap <leader>tt :tabnew<cr>:edit term://bash<cr>i
nmap <leader>te :tabnew<cr>-
nmap <leader>t1 :tabnew<cr>:Startify<cr>
nmap <leader>tc :tabclose<cr>
if has("nvim")
  au TermOpen * tnoremap <Esc> <c-\><c-n>
  au FileType fzf tunmap <Esc>
endif

" <leader><leader> toggles betwen buffers
nnoremap <leader><leader> <c-^>

" Vimspector
fun! GotoWindow(id)
  call win_gotoid(a:id)
  " MaximizerToggle
endfun
nnoremap <leader>dd :call vimspector#Launch()<cr>
nnoremap <leader>dc :call GotoWindow(g:vimspector_session_windows.code)<cr>
nnoremap <leader>dt :call GotoWindow(g:vimspector_session_windows.tagpage)<cr>
nnoremap <leader>dv :call GotoWindow(g:vimspector_session_windows.variables)<cr>
nnoremap <leader>dw :call GotoWindow(g:vimspector_session_windows.watches)<cr>
nnoremap <leader>ds :call GotoWindow(g:vimspector_session_windows.stack_trace)<cr>
nnoremap <leader>do :call GotoWindow(g:vimspector_session_windows.output)<cr>
nnoremap <leader>de :call vimspector#Reset()<cr>

nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>d_ <Plug>VimspectorRestart
nnoremap <leader>d<space> :call vimspector#Continue()<cr>

nmap <leader>drc <Plug>VimspectorRunToCursor
nmap <leader>dbb <Plug>VimspectorToggleBreakpoint
nmap <leader>dbc <Plug>VimspectorToggleConditionalBreakpoint
nmap <leader>dbl <Plug>VimspectorToggleLogpoint

" Maximizer
nnoremap <leader>m :MaximizerToggle!<cr>

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
