" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
"    Aminopterin: One heavy influence is Amir Salihefendic's `.vimrc`,
" retrived from either `github.com/amix/vimrc` or `amix.dk/vim/vimrc.txt`
"    I classfied settings according to the "Windows tradition".
"    Legend: `<cr>` for the return key, `<esc>` the escape key,
" and `<c-*>` for `Ctrl-*` (`*` means a certain key).
" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "

" First, define a "leader" to enable lots of combinations (`g` for `global`)
let mapleader = ","
let g:mapleader = ","

" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
"          File, read and write
" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "

" Do not make Vim compatible with vi
set nocompatible

" Save buffer (not if readonly or filename exists) with`,w` (for "write")
nnoremap <leader>w :w<cr>

" Quit buffer (not if buffer not being saved) with `,q` (for "quit")
nnoremap <leader>q :q<cr>

" Absolutely forbid modifying a file opened as read-only with `:vie[w]`
" (Default is first to warn, and then allow edit)
autocmd BufRead * let &l:modifiable = !&readonly

" Check file changes and prompt to reload, every moment window switched
autocmd WinEnter * checktime

" Set to auto read when a file is changed from the outside
set autoread

" Enable filetype detection, filetype-specific settings
filetype on

" Enable automatic loading of plugins upon recognizing filetype
filetype plugin on

" Enable indent in the manner suitable for the filetype
filetype indent on

" Allow unwritten buffers to be hidden (not in view)
set hidden

" Keep a backup file
set backup

" Specify where to backup files (otherwise there're lots of hidden backup files)
set backupdir=~/Documents/vim-backup

" Tell Vim where to put swap files (same place)
set dir=~/Documents/vim-backup

" Set how many lines of history Vim has to remember
set history=700

" Open `~/.vimrc` in a new tab by `,v` (for "vimrc")
nnoremap <leader>v :tabe $MYVIMRC<cr>

" Source (apply) `~/.vimrc` by `,s` (for "source")
nnoremap <leader>s :source $MYVIMRC<cr>

" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
"          Edit, search and replace
" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "

" Enable backspace to delete indentation, line breaks, pre-existing characters
set backspace=eol,start,indent

" Do not automatically supply comment-symbol (e.g. "//" in C++)
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Allow magic (which is default) so regular expressions are simplified,
" but literal `\`, `~`, `*`, `$`, `.`  each requires escape by prefixing `\`
" My mnemonic: STAMP -- backslash, tilde, asterisk, money, period
set magic

" Automatically search once a character is typed
set incsearch

" Highlight search results
set hlsearch

" But toggle not to highlight search result with `,l` (for "light")
nnoremap <leader>l :setlocal nohlsearch!<cr>

" Clean highlight of what's being searched with `,<cr>`
noremap <leader><cr> :nohlsearch<cr>

" Ignore case when searching as default
set ignorecase

" When searching, if string contains one upper case and one lower 
" case, be case sensitive, otherwise not
set smartcase

" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
"          View and windows
" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "

" Remember the list of all (`^`) opened buffers (`%`) when closing
set viminfo^=%

" Quick write session (current panes and tabs) with `,m` (for "make")
noremap <leader>m :mksession! ~/.my-auto-vim-session.vim<cr>

" Load saved session with `,o` (for "open")
noremap <leader>o :source ~/.my-auto-vim-session.vim<cr>

" Don't update the display while executing macros
set lazyredraw

" Always show current position
set ruler

" Always display line numbers
set number

" Show the present mode
set showmode

" Initialize settings in NETRW buffer (directory browser)
let g:netrw_bufsettings='nomodifiable nomodified number nobuflisted wrap readonly'

" In NETRW buffer, Hide the banner on top of files
let g:netrw_banner = 0

" In NETRW buffer, specify files to be hidden, comma-separated
let g:netrw_list_hide=
    \ '^\..*/$,' . '^\..*$,' .
    \ '^.*\.swp$,' . '^.*\.o$,' . '^.*\.pyc$' .
    \ '^.*\.pdf$,' . '^.*\.doc$,' . '^.*\.docx$' .
    \ '^.*\.png$,' . '^.*\.jpg$,' . '^.*\.jpeg$'

" In NETRW buffer, hide files specified above
let g:netrw_hide=1

" In NETRW buffer, toggle whether to hide files with `,h` (for `hide`)
noremap <silent> <leader>h :call ToggleDisplayHiddenFiles()<cr>

" Select the next tab with `,f` (for `following`)
nnoremap <leader>f gt

" Select the previous tab with `,e` (for `earlier`)
nnoremap <leader>e gT

" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
"          Tools
" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "

" Wait 3[s] for combination key, and afterwards wait 0.1[s] 
" for key codes after that (both in ms), 
" preventing delay after `O` (opening another line above)
set timeout
set timeoutlen=3000
set ttimeoutlen=100

" Height of the command bar
set cmdheight=2

" Turn on the wild menu of auto command line completion by pressing Tab
set wildmenu

" Always show the status line, with height being 2 lines
set laststatus=2

" Format the status line. They are resp.:
" `%F` full path to this file, `%m` modified flag,
" `%r` readonly flag, `%h` help buffer flag,
" `%l` current line no., `%L` total line no., `%c` current column no.,
" `%V` virtual column no. as shown on the screen (with `-` sign).
set statusline=\ %F%m%r%h\ L:%l\/%L\ C:%c%V

" Toggle spell checking on and off with`,c` (for "check")
noremap <leader>c :setlocal spell!<cr>

" Toggle paste mode (to insert by pasting) with `,p` (for "paste")
noremap <leader>p :setlocal paste!<cr>

" Set dictionary for completion, called by `<c-x><c-k>` in insert mode
set dictionary=/usr/share/dict/words

" Set source codes syntax completion, called by `<c-x><c-o>` in insert mode
set omnifunc=syntaxcomplete#Complete

" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
"          Display of text
" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "

" (See the very end of this file for more comments of mine)
" Enable syntax highlighting
syntax enable

" Use the terminal's native color for display
set termguicolors

" Use dark background
set background=dark

" Choose Romain Lafourcade's "flattened" (`romainl/flattened`) color scheme,
" based on Ethan Schoonover's "solarized" (`altercation/vim-colors-solarized`)
" (see note in README.md in the same directory)
colorscheme flattened

" Switch among my favorite color schemes with `,t` (for `theme`)
nnoremap <leader>t :call ChooseNextColor()<cr>

" Make comments shown in terminal, italic; GUI MacVim already does
highlight Comment cterm=italic

" Set utf8 as standard encoding
set encoding=utf8

" Force to use Unix-styled end-of-line (EOL)
" (see note in README.md in the same directory)
set fileformat=unix
set fileformats=unix

" Force wide characters (like Chinese) are displayed twice as wide
set ambiwidth=double 

" Use spaces instead of tab-space
set expandtab

" 1 tab-space is 3 spaces
set shiftwidth=3
set tabstop=3

" Break lines instead of split a word when wrapping
set linebreak

" But toggle linebreak or not by `,b` (for "break")
nnoremap <leader>b :setlocal nolinebreak!<cr>

" Wrap lines in displaying
set wrap

" Never automatically wrap text by setting to 0, however long it is
set textwidth=0

" Toggle between displaying, as much as possible, the next line
" not able to be fully shown, or not so, by `,d` (for "display")
set display=
noremap <silent> <leader>d :call ToggleDisplayLastLine()<cr>

" Mark newline, tabbed space, and unfinished or continued lineas
set listchars=eol:~,tab:>\ ,extends:+,precedes:-
set list

" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
"          Navigation and cursor
" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "

" Treat long lines as break lines, so as to navigate in a wrapped line
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" For these navigation actions, continue navigation acrossing newline
set whichwrap+=<,>,h,l

" Scroll a page with no repeated lines, instead of two lines in both
" before and after; leaving cursor in the middle
nnoremap <c-f> <c-f><c-e><c-e>M
nnoremap <c-b> <c-b><c-y><c-y>M

" Scroll half a page, with cursor in the middle after that
nnoremap <c-d> <c-d>M
nnoremap <c-u> <c-u>M

" Jump to previous / next fullwidth CJK punctuation mark (in normal mode)
nnoremap <silent> <c-k> ?[、，；。！？：“”‘’「」『』—]<cr>:noh<cr>
nnoremap <silent> <c-j> /[、，；。！？：“”‘’「」『』—]<cr>:noh<cr>

" Return to last edit position upon opening files
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" Turn off the blinking cursor in normal (`n`) mode (relevant in MacVim)
set guicursor=n:blinkon0

" Disallow "mouse" (i.e. trackpad or whatever) to change cursor location
set mouse-=a

" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
"          Helper functions's implementation
" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "

function! ToggleDisplayLastLine()
    if (&display=='')
        let &display='truncate'
    else
        let &display=''
    endif
endfunction

function! ToggleDisplayHiddenFiles()
    if (g:netrw_hide==0)
        let g:netrw_hide=1
    else
        let g:netrw_hide=0
    endif
endfunction

" This function switches among my favorite color schemes only.
" To add a color scheme, place desired `.vim` in `~/.vim/colors`
function! ChooseNextColor()
    if (g:colors_name=='flattened')
        :colorscheme gruvbox
    elseif (g:colors_name=='gruvbox')
        :colorscheme tomorrow-eighties
    elseif (g:colors_name=='tomorrow-eighties')
        :colorscheme tomorrow-bright
    elseif (g:colors_name=='tomorrow-bright')
        :colorscheme molokai
    elseif (g:colors_name=='molokai')
        :colorscheme default
    elseif (g:colors_name=='default')
        :colorscheme flattened
    endif

    highlight Comment cterm=italic
endfunction
