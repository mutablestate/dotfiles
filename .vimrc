" load up pathogen and all bundles
call pathogen#infect()
call pathogen#helptags()

set nocompatible
syntax on
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

set nowrap

"""""""""""""""""""""""""""""""""""""""
" BACKUP / TMP FILES
"""""""""""""""""""""""""""""""""""""""
" taken from
" http://stackoverflow.com/questions/4331776/change-vim-swap-backup-undo-file-name
" Save your backups to a less annoying place than the current directory.
" If you have .vim-backup in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/backup or . if all else fails.
if isdirectory($HOME . '/.vim/backup') == 0
  :silent !mkdir -p ~/.vim/backup >/dev/null 2>&1
endif
set backupdir-=.
set backupdir+=.
set backupdir-=~/
set backupdir^=~/.vim/backup/
set backupdir^=./.vim-backup/
set backup

" Save your swp files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swap') == 0
  :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

" viminfo stores the the state of your previous editing session
set viminfo+=n~/.vim/viminfo

if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/undo//
  set undofile
endif

"""""""""""""""""""""""""""""""""""""""
" GENERAL EDITING SETUP
"""""""""""""""""""""""""""""""""""""""
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=

" display incomplete commands
set showcmd

let mapleader = ","

" Set encoding
set encoding=utf-8

" Whitespace stuff
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmenu
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

" multi-purpose tab key (auto-complete)
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" Status bar
set laststatus=2

" Turn off menu in gui
set guioptions="agimrLt"
" Turn off mouse click in gui
set mouse=""

let g:airline_theme='luna'
let g:airline_powerline_fonts=1

let g:molokai_original=1
let g:rehash256=1

" Theme...
" delegate colorscheme configuration to config/color/<colorscheme>.vim files
autocmd ColorScheme * execute 'runtime config/color/'. g:colors_name .'.vim'

" terminals that I typically use have a dark background color
set background=dark

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

set t_Co=256
"set t_Co=16
set background=dark
colorscheme solarized
"colorscheme Tomorrow-Night-Eighties
"colorscheme base16-default
"colorscheme grb256
"colorscheme mustang
"colorscheme xoria256
"colorscheme wombat256
"colorscheme zenburn
"colorscheme molokai
"colorscheme base16-eighties

" highlight the current line
set cursorline
" Highlight active column
set cuc cul

" Show linenumbers
set number
set ruler

" Use Powerline
"let g:Powerline_symbols="fancy"
"python from powerline.bindings.vim import source_plugin; source_plugin()

" Font
"set guifont="Terminus\ 9"

" Show trailing whitespace and spaces before a tab:
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\\t/

" Remove trailing whitespace
autocmd BufWritePre {*.rb,*.js,*.coffee,*.scss,*.haml,*.ex,*.exs,*.eex} :%s/\s\+$//e

augroup markdown
  au!
  au BufReadPost *.md,*.markdown setlocal tw=80
  au BufNewFile,BufRead *.md,*.markdown setlocal filetype=markdown
augroup END

augroup elixir
  au!
  au FileType elixir noremap <buffer> <leader>t :!mix test<cr>
augroup END

augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()

  au BufReadPost *.thor set syntax=ruby
  au BufReadPost *.ts set syntax=typescript

  " ftdetect isn't being pulled in from the vim-slim plugin for some reason
  autocmd BufNewFile,BufRead *.slim set filetype=slim

  autocmd BufNewFile,BufRead *.coffee set filetype=coffee

  " ftdetect isn't being pulled in from vim-elixir for some reason
  au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
  au FileType elixir setl sw=2 sts=2 et iskeyword+=!,?

  " ftdetect for Arduino
  au BufRead,BufNewFile *.pde set filetype=arduino
  au BufRead,BufNewFile *.ino set filetype=arduino

  " ftdetect for less
  au BufRead,BufNewFile *.less set filetype=less
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Open the alternate file
map ,, <C-^>

" Can't be bothered to understand ESC vs <c-c> in insert mode
imap <c-c> <esc>
" Clear the search buffer when hitting return
function! MapCR()
  nnoremap <cr> :nohlsearch<cr>
endfunction
call MapCR()

" Ack bits
map <leader>a :Ag 

" Remove highlights
nmap <Leader><CR> :nohlsearch<cr>

" Run this file with rake
map <leader>t :VroomRunTestFile<cr>
map <leader>T :VroomRunNearestTest<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NO ARROW KEYS COME ON
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Left> :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up> :echo "no!"<cr>
map <Down> :echo "no!"<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIR OF CURRENT FILE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

"""""""""""""""""""""""""""""""""""""""
" Enable per-project vimrcs
"""""""""""""""""""""""""""""""""""""""
set exrc   " enable per-directory .vimrc files
set secure " disable unsafe commands in local .vimrc files

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Start scrolling 3 lines before the border
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set scrolloff=3

""""""""""""""""""""""""""""""""""""""""""
" Custom split opening / closing behaviour
""""""""""""""""""""""""""""""""""""""""""
set splitbelow
map <C-N> :vsp .<CR>
map <C-C> :q<CR>

"""""""""""""""""""
" ctrlp settings
"""""""""""""""""""
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
