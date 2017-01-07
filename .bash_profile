# to adjust default color
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx # some color settings used by ls display
export CLICOLOR=1 # to enable color
# Prompt present time in minutes, and current directory (rather than full path)
export PS1='\[\033[0;32m\]aminopterin\[\033[0;34m\][\A]\[\033[0;31m\]@\W\[\033[1;37m\]$ '
ls="ls -GFh" # G: to enable colorized output; F: to display a slash; h: human readable, e.g. KB, MB, GB,...

# to hide and show files
alias ShowFiles='defaults write com.apple.finder AppleShowAllFiles YES' # show hidden files in Mac Finder.app
alias HideFiles='defaults write com.apple.finder AppleShowAllFiles NO' # show hidden files in Mac Finder.app

# cd shortcuts
alias GoToDesktop='cd /Users/amino/Desktop'
alias GoToEssays='cd /Users/amino/Documents/7.\ essays\,\ since\ July\ 2015'
alias GoToAllFairCopies='cd /Users/amino/Documents/all\ fair\ copies'
alias GoToLilyPondWork='cd /Users/amino/Documents/lilypond-work'
alias GoToLaTexWork='cd /Users/amino/Documents/latex-work/vol-2-spr-2016'
alias GoToPrograms='cd /Users/amino/Documents/programs-of-mine'
alias GoToStackExchange='cd /Users/amino/Documents/stack-exchange-questions'
alias GoToBooks='cd /Users/amino/Documents/all\ books'

# app shortcuts
# note: & runs process as background
# note: "$@" (with quotes) expands to all parameters being passed
# note: suppose str=foo.bar.qux

# to compile LilyPond .ly file
alias LilyPond='/Applications/LilyPond.app/Contents/Resources/bin/lilypond'

# to open as pure text with TextEdit
function TextEdit(){
   open -a TextEdit "$@" &
}

# to open with MacVim in the terminal
alias Vim='mvim -v'

# to open Bash profile
alias OpenBashProfile='mvim -v ~/.bash_profile'

# to source Bash profile
alias SourceBashProfile='. ~/.bash_profile'

# to read Markdown (without LaTeX), displayed by lynx
function ReadMarkdownInTerminal(){
   pandoc "$1" | lynx -stdin
}

# to export Markdwn (with LaTeX)
# then "${str%%.*}" is foo, and "${str%.*}" is foo.bar
# and "${str##.*}" is qux, and "${str#.*}" is bar.qux
# pandoc options: -s for standalone, -o for output,
# -V for value, margin meaning page margin
# --template is called for latex compiler's use
# xelatex is required for CJK characters
function ExportMarkdownToPdf(){
   nameMd=$1
   namePdf='${nameMd%%.*}.pdf'
   opt="-s \
         -o ${namePdf} \
         -V geometry:margin=1in \
         --template=/Users/amino/pandoc-template.latex \
         --latex-engine=xelatex"
   tmp="pandoc ${opt} ${nameMd}"
   echo ${tmp} # first print it
   eval ${tmp} # then evaluate it
}
