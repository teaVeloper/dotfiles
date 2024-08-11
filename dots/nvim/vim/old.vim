" ==========================================================================
"                                                                           |
"                        NVIM Configuration                                 |
"                                                                           |
"   Plugins managed via vim-plug https://github.com/junegunn/vim-plug       |
" ==========================================================================


scriptencoding utf-8
set mouse=

" Import Plugins {{{
source $HOME/dotfiles/vim/vimplugins.vim
" }}}

" Basic Settings {{{

syntax enable
set nocompatible          " do not run in legacy vi mode
set encoding=utf-8
set ruler                 " show line and column ruler on bottom
set nonumber              " no line numbers on default
set hidden                " Allow buffers to be backgrounded without being saved
set noswapfile            " Prevent vim from creating swap files
" set scrolloff=999         " Keep the cursor centered in the screen
set showmatch             " Highlight matching braces
set splitbelow            " Splits show up below by default
set splitright            " Splits go to the right by default
set nohlsearch            " Startup with no search Highlighting - annoys me, can be toggled
set incsearch             " Start showing results as you type
set smartcase             " Be smart about case sensitivity when searching

set termguicolors         " Enable termguicolors, as is more beautiful
colorscheme solarized8_dark_flat

" Tabsettings
set tabstop=2
set softtabstop=2
set expandtab

set laststatus=2
let python_highlight_all=1

set wildmenu
set showmatch
set wrap

let g:python3_host_prog = expand('/usr/bin/python3')

set foldmethod=marker     " Set folding on markers by default


set undofile              " Persisten Undo Files
if !has('nvim')
    set undodir=$XDG_DATA_HOME/nvim/undo
endif
augroup pers_undo
    autocmd!
    " avoid cluttering with tmp files
    autocmd BufWritePre /tmp/* setlocal noundofile
augroup END

" }}}

" Key Bindings {{{

let mapleader = "\\"  " first \ is escape sequence, thus \ is leader
let maplocalleader = "-"

" Toggle HL Search
nnoremap <silent> <Leader>h :set invhlsearch<CR>
" Edit vim settings
nnoremap <localleader>ev :split $MYVIMRC<cr>
" Copy and Paste to system buffers
nnoremap <leader>y "+y
nnoremap <leader>p "+p
" copy and paste with x window clipboard
nnoremap <localleader>y "*y
nnoremap <localleader>p "*p
" annoyed me when pressing unintentional.. mauybe will change
nnoremap Q <nop>
"Save on <Leader>w to not have to press :
noremap <Leader>w :write<CR>
" Accidently running :W for saving shall create desired result
" Also W command annoyed me
command! W w
" Shortcut for fuzzfinder
nnoremap <Leader>e :FZF<CR>
" Line number toggles and turn off
noremap <localleader>nn :set number!<CR>
noremap <localleader>nr :set relativenumber!<CR>
noremap <localleader>no :set nonumber norelativenumber<CR>
" vertical split
nnoremap <Leader>v :vs<Enter>

" -- Moving
" switch visual line and per line movement
nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k
"  Remap Windows Movements
inoremap <C-Left> <Esc><c-w>h
inoremap <C-Down> <Esc><c-w>j
inoremap <C-Up> <Esc><c-w>k
inoremap <C-Right> <Esc><c-w>l
inoremap <C-h> <Esc><c-w>h
inoremap <C-j> <Esc><c-w>j
inoremap <C-k> <Esc><c-w>k
inoremap <C-l> <Esc><c-w>l


" Insert customized todo
" " TODO (Berti): rething mappings!
    " nnoremap <Leader>td :call NERDComment(0, "append")<C-m>TODO (Berti):
    " inoremap <C-t> <Esc>:call NERDComment(0, "append")<C-m>TODO (Berti):
    " " no nerdcommenter anymore, use commentary.vim - rethink of a todo
    " command

" }}}

"  Plugin Config {{{

" behaviour of FZF search
let $FZF_DEFAULT_COMMAND="rg --files --hidden -g '!.git'"

" Linting
let g:syntastic_python_checker = ['flake8']
let g:syntastic_python_checkers = ['python']
let g:syntastic_python_python_exec = 'python3'

" ALE Settings
" Allow longer lines .e.g. 120 can be changed later
" ignore C0330 hanging indents, as black formats different
let g:ale_python_flake8_options = '--max-line-length=120 --inline-quotes '"''
let g:ale_yaml_yamllint_options = '-d "{extends: relaxed, rules: {line-length: {max: 120}} }"'
let g:ale_python_pylint_options = '-d E0401,C0112,C0103,C0116,C0115,C0114,R0903,R1705,W0621'
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'


let g:lightline = {
   \     'colorscheme': 'wombat',
   \     'active': {
   \         'left': [['mode', 'paste' ], ['gitbranch', 'readonly', 'filename', 'modified']],
   \         'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding'], ['bufnum']]
   \     },
   \     'component_function': {
   \         'gitbranch': 'FugitiveHead'
   \     },
   \ }


" enable ncm2 for all buffers
    autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
    set completeopt=noinsert,menuone,noselect

" Slime vim
let g:slime_target = "tmux"

" }}}

" Layout {{{
"  Tab Settings
hi TabLine      guifg=#333 guibg=#222 gui=none ctermfg=254 ctermbg=238 cterm=none
hi TabLineSel   guifg=#666 guibg=#222 gui=bold ctermfg=231 ctermbg=235 cterm=bold
hi TabLineFill  guifg=#999 guibg=#222 gui=none ctermfg=254 ctermbg=238 cterm=none

" }}}

" Autocommand Groups {{{

" https://stackoverflow.com/questions/46945493/disable-autocmd-project-specific-in-vim
" somehow i copied this here

" autoformat python
augroup pyformat
    autocmd!
    autocmd BufWritePre *.py execute ':Black'
    autocmd BufWritePre *.py execute ':Isort'
augroup END


augroup jinja
    autocmd!
    autocmd BufRead,BufNewFile *.yml.j2,*.yaml.j2 set filetype=yaml
augroup END

" }}}
