" --------------------------------------
" Plugins to be loaded and some configuration
"
"
" ----------------------------------------

" Maybe its annoying to have this separate
" to init.vim?

call plug#begin()


" Default settings from sensible plugin
Plug 'tpope/vim-sensible'

" Syntax Highlighting
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Status Line
Plug 'itchyny/lightline.vim'

" Comments
Plug 'preservim/nerdcommenter'

" Edit surroundings
Plug 'tpope/vim-surround'

" Syntax
Plug 'vim-syntastic/syntastic'
Plug 'nvie/vim-flake8'
Plug 'itspriddle/vim-shellcheck'

" ?
Plug 'jnurmine/Zenburn'

Plug 'altercation/vim-colors-solarized'

Plug 'dracula/vim', { 'as': 'dracula' }


Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-endwise'

" autocomplete
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'

Plug 'davidhalter/jedi-vim'

Plug 'tpope/vim-unimpaired'

" projectionist - project specific mappings
Plug 'tpope/vim-projectionist'

" Ack-Grep Wrapper
Plug 'mileszs/ack.vim'

" Black python formatter
Plug 'psf/black'
Plug 'fisadev/vim-isort'

" Terminal
" Plug 'kassio/neoterm'

" Tests
Plug 'vim-test/vim-test'

" For editorconfig project
Plug 'editorconfig/editorconfig-vim'

Plug 'integralist/vim-mypy'


Plug 'raghur/vim-ghost', {'do': ':GhostInstall'}
Plug 'cespare/vim-toml', { 'branch': 'main' }

" TMux
Plug 'christoomey/vim-tmux-navigator'
Plug 'preservim/vimux'
Plug 'jgdavey/tslime.vim'

" seek with s and two characters like f
Plug 'goldfeld/vim-seek'

" Vim ale
Plug 'dense-analysis/ale'

" Filetypes
Plug '/sheerun/vim-polyglot'

" Colorscheme and Management
" Vanity is very annoying and aggresive
" Plug 'whatever555/vanity'
Plug 'flazz/vim-colorschemes'
" Plug 'rafi/awesome-vim-colorschemes'
" Plug 'rainglow/vim'
" Plug 'mswift42/vim-themes'
"

" No leakage of passwords from pass
Plug 'https://gitlab.com/craftyguy/vim-redact-pass.git'

call plug#end()
