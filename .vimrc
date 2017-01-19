" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
"    Aminopterin: One heavy influence is Amir Salihefendic's `.vimrc`,
" retrived from either `github.com/amix/vimrc` or `amix.dk/vim/vimrc.txt`
"    I classfied settings in the manner of a usual GUI toolbar.
"    Legend: `<cr>` for the return key, `<esc>` the escape key,
" <bs> for the backspace, <space> for the spacebar,
" and `<ctrl-*>` for `Ctrl-*` if `*` is some key).
"    Though abbreviations exitst, I use full name form for ease of reading.
" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "

" First, define a "leader" to be the space bar, after turning off
" its default behavior (right arrow). The enables lots more combinations.
nnoremap <space> <Nop>
let mapleader=" "

" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
"          File, read and write
" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "

" Do not make Vim compatible with vi
set nocompatible

" Save current buffer  with `<space>w` (for "write")
" (not if readonly or filename exists)
nnoremap <leader>w :w<cr>

" Quit window with `<space>q` (for "quit")
" (not if buffer not being saved)
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
set backupdir=~/Documents/vim_backup

" Tell Vim where to put swap files (same place)
set dir=~/Documents/vim_backup

" Set how many lines of history Vim has to remember
set history=700

" Open `~/.vimrc` in a new tab by `<space>v` (for "vimrc")
nnoremap <leader>v :tabe $MYVIMRC<cr>

" Source (apply) `~/.vimrc` by `<space>s` (for "source")
nnoremap <leader>s :source $MYVIMRC<cr>

" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
"          Edit, search and replace
" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "

" Define `<shift>y` for "copying to end of line" for consistency (compare `D`)
nmap Y y$

" Put (paste) from the system clipboard with `<space>p` and so on
nnoremap <leader>p "*p
nnoremap <leader>P "*P

" Yank (copy) from the system clipboard with `<space>y` and so on
noremap <leader>y "*y
noremap <leader>Y "*Y
noremap <leader>yy "*yy

" Delete (cut) from the system clipboard with `<space>d` and so on
noremap <leader>d "*d
noremap <leader>D "*D
noremap <leader>dd "*dd

" Enable backspace to delete indentation, line breaks, pre-existing characters
set backspace=eol,start,indent

" Wait 3[s] for combination key, and afterwards wait 0.1[s] 
" for key codes after that (both in ms), 
" preventing delay after `O` (opening another line above)
set timeout
set timeoutlen=3000
set ttimeoutlen=100

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

" But toggle not to highlight with `<space>l` (for "highlight")
nnoremap <leader>h :setlocal nohlsearch!<cr>

" Temporarily clean highlight of what's being searched with `<space><cr>`
noremap <leader><cr> :nohlsearch<cr>

" Ignore case when searching as default
set ignorecase

" When searching, if string contains one upper case and one lower 
" case, be case sensitive, otherwise not
set smartcase

" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
"          View, windows, and NETRW
" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "

" Remember the list of all (`^`) opened buffers (`%`) when closing
set viminfo^=%

" Save session (like current windows) with `<space>m` (for "make")
noremap <leader>m :mksession! ~/.my_vim_session.vim<cr>

" Load saved session with `<space>o` (for "open")
noremap <leader>o :source ~/.my_vim_session.vim<cr>

" Don't update the display while executing macros
set lazyredraw

" Redraw screen  with `<space>r` (for "refresh")
" since I have mapped `<ctrl>l` for toggling linebreak
nnoremap <leader>r <c-l>

" Always show current position
set ruler

" Always display line numbers
set number

" Show the present mode
set showmode

" Move windows simply by `<ctrl>` plus `h`, `j`, `k`, or `l`
nnoremap <c-k> <c-w>k
nnoremap <c-j> <c-w>j
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

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

" In NETRW buffer, toggle whether to hide files with `<space>h`
" (think of `.` that prefixes hidden files)
noremap <silent> <leader>. :call ToggleDisplayHiddenFiles()<cr>

" Select the previous tab with `<space>9` (think of `(`)
" Select the next tab with `<space>0` (think of `)`)
nnoremap <leader>9 gT
nnoremap <leader>0 gt

" Select the previous buffer with `<space>[`
" Select the next buffer with `<space>]`
nnoremap <leader>[ :bprevious<cr>
nnoremap <leader>] :bnext<cr>

" Open a new tab with `<space>=` showing current file (think of `+`)
" Close the current tab with `<space>-`
nnoremap <leader>= :tabedit %<cr>
nnoremap <leader>- :tabclose<cr>

" Open a new buffer with `<space>n` (for "new")
" Delete current buffer with `<space>x` (think of `x` that deletes)
nnoremap <leader>n :enew<cr>
nnoremap <leader>x :bprevious<cr>:bdelete #<cr>

" Switch, with `<space>b` (for "buffer"), among existing
" buffers by typing its number shown on the screen
nnoremap <leader>b :ls<cr>:buffer 

" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
"          Command bar and other tools
" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "

" Press backspace to initiate internal commands
nnoremap <bs> :

" Press enter to initiate external shell commands
nnoremap <cr> :!

" Height of the command bar set to 2 lines
set cmdheight=2

" Turn on the wild menu of auto command line completion by pressing Tab
set wildmenu

" Always show the status line, with height being 2 lines
set laststatus=2

" Format the status line. They are resp.:
" `%F` full path to this file, `%m` modified flag,
" `%r` readonly flag, `%h` help buffer flag,
" `%b` buffer number, `%l` current line no.,
" `%L` total line no., `%c` current column no.,
" `%V` virtual column no. as shown on the screen (with `-` sign).
set statusline=\ %F%m%r%h\ B:%n\ L:%l\/%L\ C:%c%V

" Toggle spell checking on and off with`<space>c` (for "check")
noremap <leader>c :setlocal spell!<cr>

" Set dictionary for completion, called by `<ctrl>x<ctrl>-k` in insert mode
set dictionary=/usr/share/dict/words

" Set source codes syntax completion, called by `<ctrl>x<ctrl>-o` in insert mode
set omnifunc=syntaxcomplete#Complete

" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
"          Display of text
" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "

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

" Switch among my favorite color schemes with `<space>t` (for "theme")
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

" But toggle linebreak or not with `<space>b` (for "line")
nnoremap <leader>l :setlocal nolinebreak!<cr>

" Wrap lines in displaying
set wrap

" Never automatically wrap text by setting to 0, however long it is
set textwidth=0

" Not to display last line, if incomplete
set display=

" But toggle between displaying, as much as possible, the next line
" not able to be fully shown, or not so, with `<space>\`
" (think of `\` that indicates line continuation)
noremap <silent> <leader>\ :call ToggleDisplayLastLine()<cr>

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
nnoremap <silent> <leader>k ?[、，；。！？：“”‘’「」『』—]<cr>:noh<cr>
nnoremap <silent> <leader>j /[、，；。！？：“”‘’「」『』—]<cr>:noh<cr>

" Return to last edit position upon opening files
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" Turn off the blinking cursor in normal (`n`) mode (relevant in MacVim)
set guicursor=n:blinkon0

" Disallow "mouse" (i.e. trackpad or whatever) to change cursor location
set mouse=

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

" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
"          Summary of custom leader commands
" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "

" Short summary in alphabetical order:
" <space><cr>   Cancel highlight of the last search
" <space>.      Toggle whether to hide files in NETRW
" <space>-      Close the current tab
" <space>=      Open a new tab with a new buffer
" <space>[      Select the previous buffer
" <space>]      Select the next buffer
" <space>0      Select the next tab
" <space>9      Select the previous tab
" <space>b      Choose among existent buffers by number
" <space>c      Toggle spell checking or not
" <space>d      Cut from system clipboard (similar for `D`, `dd`)
" <space>h      Toggle whether to highlight search
" <space>m      Save the current session
" <space>n      Open a new buffer
" <space>o      Load the saved session
" <space>p      Paste from system clipboard (similar for `P`)
" <space>q      Quit the current window
" <space>r      Redraw the screen
" <space>s      Source vimrc
" <space>t      Choose among themes I favored
" <space>v      Open vimrc in new tab
" <space>w      Save the current buffer
" <space>x      Close the current buffer
" <space>y      Copy from system clipboard (similar for `Y`, `yy`)

" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
"          Regex workbench
" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "

" In these leader-prefixed registers saved are some regex commands
" I find useful; they are not necessarily important or of lasting virtue.

" To replace trailing whitespaces and newline with newline and one whitespace
nnoremap <leader>1 :%s/\s*\n\{1}\([^ \)/\r \1/g<cr>

" To remove trailing whitespaces
nnoremap <leader>2 :%s/\s\+$//g<cr>

" To remove physical newlines within a intended paragraph XXX
" ??????
nnoremap <leader>3 :%s/\n\{1}//g<cr>

"nnoremap <leader>4 






