" ====================================================
"  ~My init.vim~
"  ===================================================
"  Author: Chris Jones [http://chrisrjones.com]
"  Source: https://github.com/ipatch/dotfiles/blob/master/config/nvim/init.vim
"  ===========================================================================


call plug#begin('~/.config/nvim/plugged')

" Plugins go here.  Example:
" Plug 'foo/bar'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  let g:deoplete#enable_at_startup = 1
  " use tab for completion
  inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" Polyglot loads language support on demand!
Plug 'sheerun/vim-polyglot'
Plug 'tomasr/molokai'
Plug 'neomake/neomake'
  augroup localneomake
    autocmd! BufWritePost * Neomake
  augroup END
  " Don't tell me to use smartquotes in markdown ok?
  let g:neomake_markdown_enabled_makers = []
  " Configure a nice credo setup, courtesy https://github.com/neomake/neomake/pull/300
  let g:neomake_elixir_enabled_makers = ['mycredo']
  function! NeomakeCredoErrorType(entry)
    if a:entry.type ==# 'F'      " Refactoring opportunities
      let l:type = 'W'
    elseif a:entry.type ==# 'D'  " Software design suggestions
      let l:type = 'I'
    elseif a:entry.type ==# 'W'  " Warnings
      let l:type = 'W'
    elseif a:entry.type ==# 'R'  " Readability suggestions
      let l:type = 'I'
    elseif a:entry.type ==# 'C'  " Convention violation
      let l:type = 'W'
    else
      let l:type = 'M'           " Everything else is a message
    endif
    let a:entry.type = l:type
  endfunction

  let g:neomake_elixir_mycredo_maker = {
        \ 'exe': 'mix',
        \ 'args': ['credo', 'list', '%:p', '--format=oneline'],
        \ 'errorformat': '[%t] %. %f:%l:%c %m,[%t] %. %f:%l %m',
        \ 'postprocess': function('NeomakeCredoErrorType')
        \ }	
Plug 'c-brenn/phoenix.vim'
Plug 'tpope/vim-projectionist' " required for some navigation features.
Plug 'slashmili/alchemist.vim'
Plug 'powerman/vim-plugin-AnsiEsc' " makes the documentation look pretty :)
Plug 'tpope/vim-commentary'

call plug#end()

" Easy access to the start of the line, the below configuration will
" map the '^' key to the '0' key, and move the cursor to the first
" character of a line.
nmap 0 ^

" Want to set this before any others, the default 'leader' key is \
" set the 'leader' key to ','
let g:mapleader = ','

" Note - the below configuration line will map the 'space bar' to ':' so that
" way 'Shift+;' does not have to be pressed to begin a command in normal mode.
nmap <space> :

" Note - the below insert mappings will bind 'jk' / 'kj' to the ESC
" key functionality, so the ESC key does not need to be pressed in insert 
" mode.
imap jk <esc>
imap kj <esc>

" the below key mapping will indent the entire file
map <Leader>i mmgg=G`m<CR>

" Sane tabs
" - Two spaces wide
set tabstop=2
set softtabstop=2
" - Expand them all
set expandtab
" - Indent by 2 spaces by default
set shiftwidth=2

" Line numbers
set number

" set character encoding
set encoding=utf-8

" Highlight search results
set hlsearch
" Incremental search, search as you type
set incsearch
" Ignore case wehn searching
set ignorecase
" Ignore case when searching lowercase
set smartcase
" Stop highlighting on Enter
map <CR> :nohl<CR>

" Highlight current line
set cursorline

" Set the title on the terminal tab
set title

set background=dark
syntax enable
colorscheme molokai

" move cursor with mouse
set mouse=a

" Easy commenting of lines using tpope's plugin.
noremap <leader>c :Commentary<cr>


