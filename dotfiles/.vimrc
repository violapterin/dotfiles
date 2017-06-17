" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
"
" Filename: .vimrc
" Date: mostly Oct. 2016 to Jan. 2017
" Author: Aminopterin (Tzu-Yu Jeng)
" Description: Settings and custom commands for Vim.
" Requirement: That this be saved in the user's home.
"
" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
"
"    It's mainly based on Amir Salihefendic's `.vimrc`
" (`github.com/amix/vimrc`), also influenced by various Stack
" Overflow and Vim Stack Exchange posts; excuse me for not having
" attributing them. Legend for keys: `<cr>` for the return key,
" `<esc>` the escape key, <bs> for the backspace, <space> for the
" spacebar, and `<c-*>` for `<ctrl>*` (holding `<ctrl>` while
" pressing * where * is some key). Though abbreviations exist, I
" shall use the full name form whenever possble, for ease of reading.
"
" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
"
"    From now on, I'll classify settings in the manner of a GUI toolbar.
"
"    *  Preparation
"    *  Helper functions' implementation
"    *  File, read, and write
"    *  Edit, search, and replace
"    *  View, windows, and NETRW
"    *  Display of text
"    *  Command bar and other tools
"    *  Navigation and cursor
"    *  Summary of custom leader commands

" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
"          Preparation
" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "

" First, to define a "leader" to be the space bar, after turning off
" its default behavior (right arrow). The enables lots more combinations.
nnoremap <space> <nop>
let mapleader = " "

" To declare a group that holds auto-commands defined in this vimrc,
" and delete all auto-commands having been defined at this point.
augroup group_vimrc
   " To clear all contents in `group_vimrc`
   autocmd!
augroup END

" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
"          Helper functions implementation
" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "

" The implementation is placed before the main body of `.vimrc`,
" in case that they are called within it, though some may not be.

" " " " " " " " " " " " " " " "

" To toggle showing text hidden for lack of space (see `<space>\`).
function! ToggleDisplayLastLine()
    if (&display == '')
        let &display = 'truncate'
    else
        let &display = ''
    endif
endfunction

" " " " " " " " " " " " " " " "

" In NETRW buffer, to toggle hiding files (see `<space>h`).
function! ToggleDisplayHiddenFiles()
    if (g:netrw_hide == 0)
        let g:netrw_hide = 1
    else
        let g:netrw_hide = 0
    endif
endfunction

" " " " " " " " " " " " " " " "

" To switch among chosen color schemes (see `<space>t`).
function! ChooseNextColor()
    if (g:colors_name == 'flattened')
        :colorscheme gruvbox
    elseif (g:colors_name == 'gruvbox')
        :colorscheme tomorrow-eighties
    elseif (g:colors_name == 'tomorrow-eighties')
        :colorscheme tomorrow-bright
    elseif (g:colors_name == 'tomorrow-bright')
        :colorscheme molokai
    elseif (g:colors_name == 'molokai')
        :colorscheme default
    elseif (g:colors_name == 'default')
        :colorscheme flattened
    endif

    highlight Comment cterm=italic

    call SetColorUsers()
endfunction

" " " " " " " " " " " " " " " "

" List buffer's filename only, suppressing path (see `<space>b`).
function! ListBuffersFilenameOnly()
    " To redirect `:ls` result, and save as `list`; `s:` makes it local.
    redir => s:list
    silent exec 'ls'
    redir END

    " Replacement syntax is same as `:s`; `g` for global action.
    " The `®` and `©` are introduced temporarily for delimitation.
    " First to isolate filenames and line numbers.
    let s:list = substitute( s:list, '"\([^\n]*\)"\s*line \(\d\+\)', 'line ®\2®: ©\1©', 'g' )

    " To keep only basename of file and strip `©`.
    let s:list = substitute( s:list, '©\([^©]*\)/\([^©/]\+\)©', '\2', 'g' )
    let s:list = substitute( s:list, '©\([^©]\+\)©', '\1', 'g' )

    " To pad whitespace to align and strip `®`.
    let s:list = substitute( s:list, '®\(\d\{1}\)®:', '\1:     ', 'g' )
    let s:list = substitute( s:list, '®\(\d\{2}\)®:', '\1:    ', 'g' )
    let s:list = substitute( s:list, '®\(\d\{3}\)®:', '\1:   ', 'g' )
    let s:list = substitute( s:list, '®\(\d\{4}\)®:', '\1:  ', 'g' )
    let s:list = substitute( s:list, '®\(\d\{5}\)®:', '\1: ', 'g' )

    echo s:list
endfunction

" " " " " " " " " " " " " " " "

" To set the statusline for all windowss.
function! RefreshStatusLine()
    for i in range(1, winnr('$'))
        call setwinvar(i, '&statusline', '%!GetStatusLine(' . i . ')')
    endfor
endfunction

" " " " " " " " " " " " " " " "

" To choose the statusline for either active or inactive windowss.
function! GetStatusLine(num_active_window)
    return a:num_active_window == winnr() ? s:active_statusline : s:inactive_statusline
endfunction

" " " " " " " " " " " " " " " "

" To set colors used in status line.
function! SetColorUsers()
    highlight User1 guifg = #ffffff  guibg = #660000
    highlight User2 guifg = #ffffff  guibg = #990033
    highlight User3 guifg = #ffffff  guibg = #666600
    highlight User4 guifg = #ffffff  guibg = #336633
    highlight User5 guifg = #ffffff  guibg = #336699
endfunction

" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
"          File, read, and write
" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "

" Prevent Vim to be compatible with Vi.
set nocompatible

" To save current buffer with `<space>w` (for "write"),
" not if readonly or filename exists.
nnoremap <leader>w :w<cr>

" To save all buffers with `<space>a` (for "all").
nnoremap <leader>a :wa<cr>

" To close buffer and quit window with `<space>q` (for "quit"),
" not if buffer not being saved.
nnoremap <leader>q :q<cr>

" To absolutely forbid modifying a file opened as read-only with `:vie[w]`.
" (Default is first to warn, and then allow edit.)
autocmd group_vimrc BufRead * let &l:modifiable = !&readonly

" To check file changes and prompt to reload, every moment Vim's
" window is focussed again. If no change in Vim, buffer is reloaded.
autocmd group_vimrc FocusGained * checktime

" To reload all opened buffers manually with `<space>e` (for "edit").
nnoremap <leader>e :bufdo e <cr>

" To set to auto read when a file is changed from the outside.
set autoread

" To enable filetype detection, filetype-specific settings.
filetype on

" To enable automatic loading of plugins upon recognizing filetype.
filetype plugin on

" To enable indent in the manner suitable for the filetype.
filetype indent on

" To allow unwritten buffers to be hidden (not in view).
set hidden

" To keep a backup file.
set backup

" To specify where backup files and swap files are saved (here the same).
let path_dir_swap = "/Users/amino/Documents/Vim_storeroom"
let &backupdir = path_dir_swap
let &dir = path_dir_swap

" To set how many lines of history Vim has to remember.
set history = 700

" To open `~/.vimrc` in a new tab with `<space>,`.
" (Preferences window of a Mac app is often opened with `<cmd>,`.)
nnoremap <leader>, :tabe $MYVIMRC<cr>

" To source (apply) `~/.vimrc` with `<space>.`
" (`.` is a Bash alias for source.)
nnoremap <leader>. :source $MYVIMRC<cr>

" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
"          Edit, search, and replace
" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "

" To copy until end of line, defined for consistency (compare `D`).
nmap Y y$

" To put (paste) from the system clipboard with `<space>p` and so on.
nnoremap <leader>p "*p
nnoremap <leader>P "*P

" To yank (copy) from the system clipboard with `<space>y` and so on.
noremap <leader>y "*y
noremap <leader>Y "*Y
noremap <leader>yy "*yy

" To delete (cut) from the system clipboard with `<space>d` and so on.
noremap <leader>d "*d
noremap <leader>D "*D
noremap <leader>dd "*dd

" To enable backspace to delete indentation, line breaks, pre-existing characters.
set backspace = eol,start,indent

" To add one whitespace only, when joining the lines with `J`.
set nojoinspaces

" Do not automatically supply comment-symbol (e.g. "//" in C++).
autocmd group_vimrc FileType * setlocal formatoptions -= c formatoptions -= r formatoptions -= o

" To wait 3[s] for combination key, and afterwards wait 0.1[s]
" for key codes after that (both in ms),
" preventing delay after `O` (opening another line above).
set timeout
set timeoutlen = 3000
set ttimeoutlen = 100

" To disable `<shift><f5>` (I mapped `<tab>` key as `<f5>` key),
" because I often accidentally hit it.
inoremap <s-f5> <nop>

" To allow magic (which is default) that simplifies regular expressions,
" but literal `\`, `~`, `*`, `$`, `.`  each requires escape by prefixing `\`
" My mnemonic: STAMP -- backslash, tilde, asterisk, money, period.
set magic

" To automatically search once a character is typed.
set incsearch

" To highlight search results.
set hlsearch

" But toggle not to highlight with `<space>l` (for "light").
nnoremap <leader>l :setlocal nohlsearch!<cr>

" To temporarily clean highlight of what's being searched with `<space><cr>`.
noremap <leader><cr> :nohlsearch<cr>

" To ignore case when searching as default.
set ignorecase

" When searching, if string contains one upper case and
" one lower case, to let Vim be case sensitive, otherwise not.
set smartcase

" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
"          View, windows, and NETRW
" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "

" To remember the list of all (`^`) opened buffers (`%`) when closing.
set viminfo^ = %

" To save session (like current windows) with `<space>m` (for "make").
noremap <leader>m :mksession! path_swap/.my_vim_session<cr>

" To load saved session with `<space>o` (for "open").
noremap <leader>o :source path_swap/.my_vim_session<cr>

" Don't update the display while executing macros.
set lazyredraw

" To always show current position.
set ruler

" To always display line numbers.
set number

" To show the present mode.
set showmode

" Suppress usual function of arrow, since I shall overload them.
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" To focus on windows with arrow keys of according direction.
nnoremap <up> <c-w>k
nnoremap <down> <c-w>j
nnoremap <left> <c-w>h
nnoremap <right> <c-w>l

" To initialize settings in NETRW buffer (directory browser).
let g:netrw_bufsettings = 'nomodifiable nomodified number nobuflisted wrap readonly'

" In NETRW buffer, to hide the banner on top of files.
let g:netrw_banner = 0

" In NETRW buffer, to specify files to be hidden, comma-separated.
let g:netrw_list_hide =
    \ '^\..*/$,' . '^\..*$,' .
    \ '^.*\.swp$,' . '^.*\.o$,' . '^.*\.pyc$' .
    \ '^.*\.pdf$,' . '^.*\.doc$,' . '^.*\.docx$' .
    \ '^.*\.png$,' . '^.*\.jpg$,' . '^.*\.jpeg$'

" In NETRW buffer, to hide files specified above.
let g:netrw_hide = 1

" In NETRW buffer, to toggle hiding files with `<space>h` (for "hide").
noremap <silent> <leader>h :call ToggleDisplayHiddenFiles()<cr>

" To select the previous buffer with `<space>[`.
" To select the next buffer with `<space>]`.
nnoremap <leader>[ :bprevious<cr>
nnoremap <leader>] :bnext<cr>

" To open a new buffer with `<space>=` (think of `+`).
" To delete current buffer with `<space>-` (meaning removal).
nnoremap <leader>= :enew<cr>
nnoremap <leader>- :bprevious<cr>:bdelete #<cr>

" To switch, with `<space>b` (for "buffer"), among existing
" buffers by typing its number shown on the screen.
" A custom function displays filename only, suppressing its full path.
nnoremap <leader>b :call ListBuffersFilenameOnly()<cr>:buffer 

" To open a new tab with `<space>n` showing current file (for "new").
" To close the current tab with `<space>c` (for "close").
nnoremap <leader>n :tabedit %<cr>
nnoremap <leader>c :tabclose<cr>

" To select the previous tab with `<space>9` (think of `(`).
" To select the next tab with `<space>0` (think of `)`).
nnoremap <leader>9 gT
nnoremap <leader>0 gt

" In a tab, to display filename only, instead of full path to it.
set guitablabel = %t

" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
"          Display of text
" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "

" To enable syntax highlighting.
syntax enable

" To use the terminal's native color for display.
set termguicolors

" To use dark background.
set background = dark

" To choose Romain Lafourcade's "flattened" (`romainl/flattened`)
" color scheme, based on Ethan Schoonover's "solarized" scheme
" (`altercation/vim-colors-solarized`); see my note in this repo.
colorscheme flattened

" Colors of the status line, for the only active windows only.
" They must come after `colorscheme` file is read.
call SetColorUsers()

" To switch among my favorite color schemes with `<space>t` (for "theme").
nnoremap <leader>t :call ChooseNextColor()<cr>

" To highlight the line where cursor is, but only in current buffer.
autocmd group_vimrc VimEnter,WinEnter,BufWinEnter * setlocal cursorline
autocmd group_vimrc WinLeave * setlocal nocursorline

" To make comments shown in terminal, italic; GUI MacVim already does.
highlight Comment cterm = italic

" To set utf8 as standard encoding.
set encoding = utf8

" To try Unix-styled end-of-line only (see relevant note in this repo).
set fileformats = unix

" To use whitespaces instead of tabbed space.
set expandtab

" To set 1 tabbed space as 3 whitespaces, when auto-indenting
" (`shiftwidth`), and when showing and interpreting a file (`tabstop`),
" and when in insert mode (`softtabstop`).
set tabstop = 3
set softtabstop = 3
set shiftwidth = 3

" To break lines instead of split a word when wrapping.
set linebreak

" But toggle linebreak or not with `<space>l` (for "line").
nnoremap <leader>l :setlocal nolinebreak!<cr>

" To wrap lines in displaying.
set wrap

" Never to automatically wrap text by setting to 0, however long it is.
set textwidth = 0

" Not to display last line, if incomplete.
set display = 

" But toggle between displaying, as much as possible, the next line
" not able to be fully shown, or not so, with `<space>\`.
" (Think of `\` that indicates line continuation.)
noremap <silent> <leader>\ :call ToggleDisplayLastLine()<cr>

" To mark newline, tabbed space, and unfinished or continued lineas.
set listchars = eol:~,tab:>\ ,extends:+,precedes:-
set list

" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
"          Command bar and other tools
" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "

" To press backspace to initiate internal commands.
nnoremap <bs> :

" To press enter to initiate external shell commands.
nnoremap <cr> :!

" To set height of the command bar to be 2 lines.
set cmdheight = 2

" To turn on the wild menu of auto command line completion with pressing Tab.
set wildmenu

" To ignore files with some extensions when completing with tab.
:set wildignore = *.swp,*.o,*.pyc,*.pdf,*.doc,*.docx,*.png,*.jpg,*.jpeg

" To always show the status line, with height being 2 lines.
set laststatus = 2

" To format the status line. They are resp.:
" `%F` full path to this file, `%m` modified flag,
" `%r` readonly flag, `%h` help buffer flag,
" `%b` buffer number, `%l` current line no.,
" `%L` total line no., `%c` current column no.,
" `%V` virtual column no. as shown on the screen (with `-` sign).
" `%1*foo%*` displays `foo` in color `User1`, and so on.
" They are defined in the lines after `colorscheme`.

" First to define that for the only active windows.
let s:active_statusline = '%1* %F %*%2*%m%r%h%*%3* B:%n %*%4* L:%l/%L %*%5* C:%c%V %*'
" Next to define those for other inactive windowss.
let s:inactive_statusline = ' %F %m%r%h B:%n  L:%l/%L  C:%c%V '

" Set the statusline whenever the active windows changes.
autocmd group_vimrc VimEnter,WinEnter,BufWinEnter * call RefreshStatusLine()

" To toggle spell checking on and off with`<space>s` (for "spell").
noremap <leader>s :setlocal spell!<cr>

" To set dictionary for completion, called with `<ctrl>x<ctrl>k` in insert mode.
set dictionary = /usr/share/dict/words

" To set source codes syntax completion, called with `<ctrl>x<ctrl>o` in insert mode.
set omnifunc = syntaxcomplete#Complete

" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
"          Navigation and cursor
" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "

" Since line-wrapping is set, to navigate in terms of display lines
" with `j` and `k`, and of physical lines with `gj` and `gk`, swapping them.
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" For these navigation actions, to continue navigation acrossing newline.
set whichwrap += <,>,h,l

" To scroll a page with no repeated lines, instead of two lines in both
" before and after; leaving cursor in the middle.
nnoremap <c-f> <c-f><c-e><c-e>M
nnoremap <c-b> <c-b><c-y><c-y>M

" To scroll half a page, with cursor in the middle after that.
nnoremap <c-d> <c-d>M
nnoremap <c-u> <c-u>M

" To jump to previous / next fullwidth CJK punctuation mark (in normal mode).
nnoremap <silent> <leader>k ?[、，；。！？：“”‘’「」『』—]<cr>:noh<cr>
nnoremap <silent> <leader>j /[、，；。！？：“”‘’「」『』—]<cr>:noh<cr>

" To return to last edit position upon opening files.
autocmd group_vimrc BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" To turn off the blinking cursor in normal (`n`) mode (relevant in MacVim).
set guicursor = n:blinkon0

" To disallow "mouse" (i.e. trackpad or whatever) to change cursor location.
set mouse =

" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "
"          Summary of custom leader commands
" " " " " " " " " " " " " " " " " " " " " " " " " " " " " " " "

" <space><cr>   To cancel highlight of the last search
" <space>,      To open `.vimrc` in a new tab
" <space>.      To source `.vimrc`
" <space>-      To delete the current buffer
" <space>=      To open a new buffer
" <space>[      To select the previous buffer
" <space>]      To select the next buffer
" <space>0      To select the next tab
" <space>9      To select the previous tab
" <space>a      To save all buffers
" <space>b      To choose among existent buffers by number
" <space>c      To close the current tab
" <space>d      To cut from system clipboard (similar for `D`, `dd`)
" <space>e      To reload all opened buffers
" <space>h      To toggle whether to hide files in NETRW
" <space>j      To jump to the next fullwidth punctuation
" <space>k      To jump to the previous fullwidth punctuation
" <space>l      To toggle whether to highlight search
" <space>m      To save the current session
" <space>n      To open a new tab with a new buffer
" <space>o      To load the saved session
" <space>p      To paste from system clipboard (similar for `P`)
" <space>q      To quit the current window
" <space>s      To toggle spell checking or not
" <space>t      To choose among themes I favored
" <space>w      To save the current buffer
" <space>y      To copy from system clipboard (similar for `Y`, `yy`)
