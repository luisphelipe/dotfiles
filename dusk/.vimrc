" URL: http://vim.wikia.com/wiki/Example_vimrc
" Authors: http://vim.wikia.com/wiki/Vim_on_Freenode
" Description: A minimal, but feature rich, example .vimrc. If you are a
"              newbie, basing your first .vimrc on this file is a good choice.
"              If you're a more advanced user, building your own .vimrc based
"              on this file is still a good idea.
" Plugins
"


call plug#begin()

Plug 'vim-autoformat/vim-autoformat'

Plug 'rhysd/vim-clang-format'

Plug 'scrooloose/nerdtree'

Plug 'terryma/vim-multiple-cursors'

Plug 'airblade/vim-gitgutter'

Plug '/usr/bin/fzf'
Plug 'junegunn/fzf.vim'

Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

Plug 'scrooloose/nerdcommenter'

Plug 'dense-analysis/ale'

Plug 'mattn/emmet-vim'

Plug 'sirver/ultisnips'
Plug 'mlaursen/vim-react-snippets'

Plug 'elzr/vim-json'
Plug 'sheerun/vim-polyglot'

Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-eunuch'

Plug 'luochen1990/rainbow'

Plug 'vim-scripts/loremipsum'

" Plug 'ycm-core/YouCompleteMe'
Plug 'Valloric/ListToggle'

Plug 'junegunn/goyo.vim'

Plug 'tpope/vim-fugitive'

" press <C-J> during INSERT mode
Plug 'tyru/eskk.vim'


call plug#end()


"------------------------------------------------------------
" Features {{{1
"
" These options and commands enable some very useful features in Vim, that
" no user should have to live without.

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
syntax on


"------------------------------------------------------------
" Must have options {{{1
"
" These are highly recommended options.

" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden

" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline


"------------------------------------------------------------
" Usability options {{{1
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
"set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display line numbers on the left
set number relativenumber

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>

if &term =~ '256color'
    " Disable Background Color Erase (BCE) so that color schemes
    " work properly when Vim is used inside tmux and GNU screen.
    set t_ut=
endif

"------------------------------------------------------------
" Indentation options {{{1
"
" Indentation settings according to personal preference.

" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=2
set softtabstop=2
set expandtab

" Indentation settings for using hard tabs for indent. Display tabs as
" four characters wide.
"set shiftwidth=2
"set tabstop=2


"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <BS> <C-L><CR><esc>

"------------------------------------------------------------
"

" Plugin Mappings and misc

" nerdtree
map <C-b> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" noh on backspack
" nnoremap <BS> :noh<return><esc>

" vim gitgutter suggestion for fasting diff
set updatetime=100

" fzf
map <C-p> :Files .<return>

" buffer navigation
map <C-h> :bprevious<CR>
map <C-l> :bnext<CR>
map <C-x> :bd<CR>

" prettier stuff
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

" remaping emmet <C-Y> to tab
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

" new keybinds for commenting text!
nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Kek, move lines around
nnoremap <C-k> :<C-u>silent! move-2<CR>==
nnoremap <C-j> :<C-u>silent! move+<CR>==
xnoremap <C-k> :<C-u>silent! '<,'>move-2<CR>gv=gv
xnoremap <C-j> :<C-u>silent! '<,'>move'>+<CR>gv=gv

" Trigger for snippets
let g:UltiSnipsExpandTrigger="<S-tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Easy-motion keybinds
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
" nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

" Remove ugly ale highlights
let g:ale_set_highlights = 0
let g:ale_enabled = 0
let g:ale_pattern_options = {'\.asm$': {'ale_enabled': 0}}
highlight clear ALEErrorSign
highlight clear ALEWarningSign

" Copy Cut Paste
vmap <C-c> "+yi
vmap <C-S-v> c<ESC>"+p
imap <C-S-v> <C-r><C-o>

" save my eyes please
colorscheme Tomorrow-Night

" Rainbow
let g:rainbow_active = 1
let g:gitgutter_enabled = 0

" YCM
" nnoremap <F9> :YcmCompleter GetDoc<CR>
" let g:lt_location_list_toggle_map = '<F10>'
" nnoremap <F11> :YcmForceCompileAndDiagnostics<CR>

" Goyo
nnoremap <F12> :Goyo<CR>

" F5 timestamp
:nnoremap <F5> "=strftime("[%H:%M]")<CR>P
:inoremap <F5> <C-R>=strftime("[%H:%M]")<CR>

" F6 date time
:nnoremap <F6> "=strftime("[%Y-%m-%d %H:%M %a]")<CR>P
:inoremap <F6> <C-R>=strftime("[%Y-%m-%d %H:%M %a]")<CR>

" F7 date
:nnoremap <F7> "=strftime("[%Y-%m-%d %a]")<CR>P
:inoremap <F7> <C-R>=strftime("[%Y-%m-%d %a]")<CR>

" DISABLE POLYGLOT FOR BASH
" let g:polyglot_disabled = ['sh']

" remap of j/k for wrapped lines
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

nmap H ^
nmap L $

" Quickly remove search highlights
nmap <F9> :nohl

" format on save for C files
let g:clang_format#auto_format = 1

" format on save for python files
let g:python3_host_prog="/usr/bin/python"
au BufWrite * :Autoformat
" let g:formatters_python = ['black']

