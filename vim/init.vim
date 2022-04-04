" ------------------------------------
" 
" NeoVim Configs, mayve also used for vim
"
" Plugins managed via vim-plug https://github.com/junegunn/vim-plug
"-------------------------------------

" Import Plugins first
source $HOME/dotfiles/vim/vimplugins.vim

" Basic settings {{

set nocompatible
set encoding=utf-8



let g:python3_host_prog = expand('/usr/bin/python3')

set hidden

" Enable termguicolors, as is more beautiful
set termguicolors
" Solarized theme works well in my terminal config
colorscheme solarized
syntax enable
set tabstop=2
set softtabstop=2
set expandtab
set ruler
set number
set wildmenu
set showmatch
set wrap

" Prevent vim from creating swap files - most of the time they simply are
" annoying
set noswapfile



" first \ is escape sequence, thus \ is leader
let mapleader = "\\"
" set - as localleader
let maplocalleader = "-"

" Search Options and Mappings {{

" Startup with no search Highlighting
set nohlsearch

" Toggle HL Search
nnoremap <silent> <Leader>h :set invhlsearch<CR>

" realign search Results - conflicts with some Plugin and never use
" nnoremap <Leader>n nzz
" nnoremap <Leader>N Nzz

" }}

" Edit vim settings " TODO (Berti): Change to localleader..
nnoremap <leader>ev :split $MYVIMRC<cr>

" Copy and Paste to system buffer to use in other tmux panes
nnoremap <leader>y "*y
nnoremap <leader>p "*p


" {{ movement customization

" switch visual line and per line movement
nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k

" annoyed me when pressing unintentional.. mauybe will change
nnoremap Q <nop>

"Save on <Leader>w to not have to press :
noremap <Leader>w :write<CR>

" Accidently running :W for saving shall create desired result
" Also W command annoyed me
command! W w

" Shortcut for fuzzfinder
noremap <Leader>ed :FZF<CR>

" behaviour of FZF search
let $FZF_DEFAULT_COMMAND="rg --files --hidden -g '!.git'"


set laststatus=2
let python_highlight_all=1
syntax on


let g:syntastic_python_checker = ['flake8']
let g:syntastic_python_checkers = ['python']
let g:syntastic_python_python_exec = 'python3'

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use alternative Format for Python as default (no space as is added already)
let g:NERDAltDelims_python = 1


" ALE Settings
" Allow longer lines .e.g. 120 can be changed later
" ignore C0330 hanging indents, as black formats different
let g:ale_python_flake8_options = '--max-line-length=120 --ignore=C0330'
" let g:ale_sign_error = '●'
" let g:ale_sign_warning = '.'

let g:lightline = { 
   \     'colorscheme': 'wombat',
   \     'active': {
   \         'left': [['mode', 'paste' ], ['gitbranch', 'readonly', 'filename', 'modified']],
   \         'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding']]
   \     },
   \     'component_function': {
   \         'gitbranch': 'FugitiveHead'
   \     },
   \ }

" Insert customized todo
" " TODO (Berti): rething mappings!
    nnoremap <Leader>td :call NERDComment(0, "append")<C-m>TODO (Berti): 
    inoremap <C-t> <Esc>:call NERDComment(0, "append")<C-m>TODO (Berti): 

" enable ncm2 for all buffers
    autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
    set completeopt=noinsert,menuone,noselect

" too long lines, 100 character, will be colored
" " TODO (Berti): annoyed me, need to refactor
highlight OverLength ctermbg=DarkGrey ctermfg=white guibg=#592929
" match OverLength /\%>100v.\+/


" {{ Tab Settings
hi TabLine      guifg=#333 guibg=#222 gui=none ctermfg=254 ctermbg=238 cterm=none
hi TabLineSel   guifg=#666 guibg=#222 gui=bold ctermfg=231 ctermbg=235 cterm=bold
hi TabLineFill  guifg=#999 guibg=#222 gui=none ctermfg=254 ctermbg=238 cterm=none


" TODO (Berti): Review Vanity.. not really nice working..
nnoremap <F8> :VanityNextCol<CR>
nnoremap <F9> :VanityPrevCol<CR>
let g:vanity_default_colors = {'allFiles': 'solarized'}

" Terminal Mode escaping with Esc - 
" if has('nvim')
        " tnoremap <Esc> <C-\><C-n>
        " tnoremap <C-v><Esc> <Esc>
" endif




"  Remap Windows Movements {{
inoremap <C-Left> <Esc><c-w>h
inoremap <C-Down> <Esc><c-w>j
inoremap <C-Up> <Esc><c-w>k
inoremap <C-Right> <Esc><c-w>l

inoremap <C-h> <Esc><c-w>h
inoremap <C-j> <Esc><c-w>j
inoremap <C-k> <Esc><c-w>k
inoremap <C-l> <Esc><c-w>l
" if has('nvim')
        " tnoremap <M-h> <c-\><c-n><c-w>h
        " tnoremap <M-j> <c-\><c-n><c-w>j
        " tnoremap <M-k> <c-\><c-n><c-w>k
        " tnoremap <M-l> <c-\><c-n><c-w>l
        " autocmd WinEnter term://* startinsert
        " autocmd TermOpen * startinsert
" endif

" vertical split
nnoremap <Leader>v :vs<Enter>

" delete trailiing whitespaces before saving py or yaml files
autocmd BufWritePre *.py :%s/\s\+$//e
autocmd BufWritePre *.yaml :%s/\s\+$//e
" Run Black and Isort on Python files
autocmd BufWritePre *.py execute ':Black'
autocmd BufWritePre *.py execute ':Isort'


" {{ Mapping for NEOTERM REPL
" if has(localnvim)
    " nnoremap <Leader><CR> :TREPLSendLine<CR>
    " vnoremap <Leader><CR> :TREPLSendSelection<CR>
" endif
