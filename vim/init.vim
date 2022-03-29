" ------------------------------------
" 
" NeoVim Configs, mayve also used for vim
"
" Plugins managed via vim-plug https://github.com/junegunn/vim-plug
"-------------------------------------

" Import Plugins first
source /home/bertold/dotfiles/vim/vimplugins.vim

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

" realign search Results
nnoremap <Leader>n nzz
nnoremap <Leader>N Nzz

" }}

" Edit vim settings
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
" use easier bindings for begining and end of line
" nnoremap H ^
" nnoremap L $


" annoyed me when pressing unintentional.. mauybe will change
nnoremap Q <nop>

"Save on <Leader>w to not have to press :
noremap <Leader>w :write<CR>
noremap <Leader>wq :wq<CR>


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
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'

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


" {{  Colorscheme stuff copied:

" Change the color scheme from a list of color scheme names.
" Version 2010-09-12 from http://vim.wikia.com/wiki/VimTip341
" Press key:
"   F8                next scheme
"   Shift-F8          previous scheme
"   Alt-F8            random scheme
" Set the list of color schemes used by the above (default is 'all'):
"   :SetColors all              (all $VIMRUNTIME/colors/*.vim)
"   :SetColors my               (names built into script)
"   :SetColors blue slate ron   (these schemes)
"   :SetColors                  (display current scheme names)
" Set the current color scheme based on time of day:
"   :SetColors now
if v:version < 700 || exists('loaded_setcolors') || &cp
  finish
endif

let loaded_setcolors = 1
let s:mycolors = [ 'blue', 'darkblue', 'default', 'delek', 'desert', 'dracula', 'elflord', 'evening', 'industry', 'koehler', 'morning', 'murphy', 'pablo', 'peachpuff', 'ron', 'shine', 'slate', 'solarized', 'torte', 'zellner', 'zenburn' ] 
" colorscheme names that we use to set color


" Set list of color scheme names that we will use, except
" argument 'now' actually changes the current color scheme.
function! s:SetColors(args)
  if len(a:args) == 0
    echo 'Current color scheme names:'
    let i = 0
    while i < len(s:mycolors)
      echo '  '.join(map(s:mycolors[i : i+4], 'printf("%-14s", v:val)'))
      let i += 5
    endwhile
  elseif a:args == 'all'
    let paths = split(globpath(&runtimepath, 'colors/*.vim'), "\n")
    let s:mycolors = uniq(sort(map(paths, 'fnamemodify(v:val, ":t:r")')))
    echo 'List of colors set from all installed color schemes'
  elseif a:args == 'my'
    let c1 = 'default elflord peachpuff desert256 breeze morning'
    let c2 = 'darkblue gothic aqua earth black_angus relaxedgreen'
    let c3 = 'darkblack freya motus impact less chocolateliquor'
    let s:mycolors = split(c1.' '.c2.' '.c3)
    echo 'List of colors set from built-in names'
  elseif a:args == 'now'
    call s:HourColor()
  else
    let s:mycolors = split(a:args)
    echo 'List of colors set from argument (space-separated names)'
  endif
endfunction

command! -nargs=* SetColors call s:SetColors('<args>')

" Set next/previous/random (how = 1/-1/0) color from our list of colors.
" The 'random' index is actually set from the current time in seconds.
" Global (no 's:') so can easily call from command line.
function! NextColor(how)
  call s:NextColor(a:how, 1)
endfunction

" Helper function for NextColor(), allows echoing of the color name to be
" disabled.
function! s:NextColor(how, echo_color)
  if len(s:mycolors) == 0
    call s:SetColors('all')
  endif
  if exists('g:colors_name')
    let current = index(s:mycolors, g:colors_name)
  else
    let current = -1
  endif
  let missing = []
  let how = a:how
  for i in range(len(s:mycolors))
    if how == 0
      let current = localtime() % len(s:mycolors)
      let how = 1  " in case random color does not exist
    else
      let current += how
      if !(0 <= current && current < len(s:mycolors))
        let current = (how>0 ? 0 : len(s:mycolors)-1)
      endif
    endif
    try
      execute 'colorscheme '.s:mycolors[current]
      break
    catch /E185:/
      call add(missing, s:mycolors[current])
    endtry
  endfor
  redraw
  if len(missing) > 0
    echo 'Error: colorscheme not found:' join(missing)
  endif
  if (a:echo_color)
    echo g:colors_name
  endif
endfunction

nnoremap <F8> :call NextColor(1)<CR>
nnoremap <S-F8> :call NextColor(-1)<CR>
nnoremap <A-F8> :call NextColor(0)<CR>

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
autocmd BufWritePre *.py execute ':Black'
autocmd BufWritePre *.py execute ':Isort'
autocmd BufWritePre *.yaml :%s/\s\+$//e
autocmd BufWritePre *.yaml :%s/\s\+$//e


" {{ Mapping for NEOTERM REPL
" if has(localnvim)
    " nnoremap <Leader><CR> :TREPLSendLine<CR>
    " vnoremap <Leader><CR> :TREPLSendSelection<CR>
" endif

" Make Vim take hql files as sql
" au BufNewFile,BufRead *.hql set filetype=sql
