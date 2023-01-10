" ==========================================================================
"                                                                           |
"                        NVIM Configuration                                 |
"                                                                           |
"   Plugins managed via vim-plug https://github.com/junegunn/vim-plug       |
" ==========================================================================

" Import Plugins {{{
source $HOME/dotfiles/vim/vimplugins.vim

" }}}

" Basic Settings {{{

" Not compatible with vi - open up more featues
set nocompatible

" Basic encoding
set encoding=utf-8

" allow hidden buffers
set hidden

" Enable termguicolors, as is more beautiful
set termguicolors
" Solarized theme works well in my terminal config
colorscheme solarized8_dark_flat

" Syntax Highlighting
syntax enable

" Tabsettings
set tabstop=2
set softtabstop=2
set expandtab

" Show ruler in statusline
set ruler

" Add line numbers by default
set nonumber


set laststatus=2
let python_highlight_all=1

set wildmenu
set showmatch
set wrap

" Prevent vim from creating swap files - most of the time they simply are
" annoying
set noswapfile

" Startup with no search Highlighting - annoys me, can be toggled
set nohlsearch

let g:python3_host_prog = expand('/usr/bin/python3')

" Set folding on markers by default
set foldmethod=marker


" Persisten Undo Files
set undofile
if !has('nvim')
    set undodir=$XDG_DATA_HOME/nvim/undo
endif
augroup pers_undo
    autocmd!
    autocmd BufWritePre /tmp/* setlocal noundofile
augroup END

" }}}

" Key Bindings / Mappings {{{

" first \ is escape sequence, thus \ is leader
let mapleader = "\\"
" set - as localleader
let maplocalleader = "-"

" Toggle HL Search
nnoremap <silent> <Leader>h :set invhlsearch<CR>

" Edit vim settings
nnoremap <localleader>ev :split $MYVIMRC<cr>

" Copy and Paste to system buffers
nnoremap <leader>y "*y
nnoremap <leader>p "*p

nnoremap <localleader>y "+y
nnoremap <localleader>p "+p


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
" " Accidently running :Q for quitting shall create desired result
" command! Q q

" Shortcut for fuzzfinder
nnoremap <Leader>e :FZF<CR>

"Save on <Leader>w to not have to press :
noremap <localleader>nn :set number!<CR>
noremap <localleader>nr :set relativenumber!<CR>
noremap <localleader>no :set nonumber norelativenumber<CR>



"  Remap Windows Movements {{{
inoremap <C-Left> <Esc><c-w>h
inoremap <C-Down> <Esc><c-w>j
inoremap <C-Up> <Esc><c-w>k
inoremap <C-Right> <Esc><c-w>l

inoremap <C-h> <Esc><c-w>h
inoremap <C-j> <Esc><c-w>j
inoremap <C-k> <Esc><c-w>k
inoremap <C-l> <Esc><c-w>l

" vertical split
nnoremap <Leader>v :vs<Enter>

"}}}

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

" Linting {{{
let g:syntastic_python_checker = ['flake8']
let g:syntastic_python_checkers = ['python']
let g:syntastic_python_python_exec = 'python3'

" ALE Settings
" Allow longer lines .e.g. 120 can be changed later
" ignore C0330 hanging indents, as black formats different
let g:ale_python_flake8_options = '--max-line-length=120 --ignore=C0330'
let g:ale_yaml_yamllint_options = '-d "{extends: relaxed, rules: {line-length: {max: 120}}}"'
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

" let g:vanity_default_colors = {'allFiles': 'solarized'}

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

" delete trailiing whitespaces before saving py or yaml files
" augroup trailspace
"     autocmd!
"     autocmd BufWritePre *.py,*.yml,*.yaml :%s/\s\+$//e
" augroup END
" if not .editorconfig
" https://stackoverflow.com/questions/46945493/disable-autocmd-project-specific-in-vim
" but also other tricks here!

" autoformat python
augroup pyformat
    autocmd!
    autocmd BufWritePre *.py execute ':Black'
    autocmd BufWritePre *.py execute ':Isort'
augroup END

augroup cookiecutter
    autocmd!
    autocmd BufNewFile,BufRead /home/bertold/workspace/berti/databricks-ci-cookie/**/**/* autocmd! pyformat
    autocmd BufWritePre /home/bertold/workspace/berti/databricks-ci-cookie/**/**/*.py execute ':Black'
augroup END


augroup jinja
    autocmd!
    autocmd BufRead,BufNewFile *.yml.j2,*.yaml.j2 set filetype=yaml
augroup END

" }}}
