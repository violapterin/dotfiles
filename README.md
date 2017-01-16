# Templates and Settings
*as of late 2016*

This repo backs up templates and settings I commonly use. 

## My `.vimrc`

The `.vimrc` is a pure text file that holds desired settings to be initialized in Vim. It specifies read-and-write settings, search-and-replace options, self-defined shortcuts, user-implemented functions, and more. If saved in the current user's home, it is read in runtime, and applied by Vim.

One short note on end-of-line styles of different file format, and another longer note on "solarized" and other color schemes, are to be found in this repo.


## My `.bashrc` and `.bash_profile`

The `.bash_profile` consists only one line, namely one that sources `.bashrc` if the latter exists.

The `.bashrc` includes all my custom appearances, shortcuts, functions, variables, and more, for the Bash shell.

For the difference between them, see a note I wrote in this repo.

## My LaTeX template for Latin languages

The `template-Latin.tex` is the LaTeX template I use, except for Chinese writings. It contain self-defined abbreviations, the load of important packages, customized appearences, self-implemented functions and more.

The LaTeX documents based on this template is supposed to be compiled into `.pdf` by `pdflatex` engine. To compile, enter `pdflatex <file-name>`. The binary `pdflatex` is already inlcuded in [MacTex](http://www.tug.org/mactex/) distribution. I run `pdflatex` on my MacBook Air. 

## My LaTeX template for Chinese, Japanese, and Korean

The `template-CJK.tex` is the LaTeX template I use for Chinese writings. It is largely the same as that of Latin laguages, but with `xeCJK` lines included, and some seemingly incompatible packages removed. 

The LaTeX documents based on this template is supposed to be compiled into `.pdf` by `pdflatex` engine. To compile, enter `xelatex <file-name>`. The binary `xelatex` is already inlcuded in [MacTex](http://www.tug.org/mactex/) distribution. I run `xelatex` on my MacBook Air. 

## The `pandoc` template I modified

When the document converter `pandoc` generates a `.pdf` from `.md` (Markdown), or from something else, actually it first prepares a intermediate `.latex` (LaTeX) file, then calls the LaTeX engine. Valid options are either `pdflatex`, `lualatex`, and `xelatex`. (Thus pandoc requires the engine called be installed in advance). 

The `pandoc` has a default LaTeX template for that. In case one need to include other packages or define other commands, he or she only has to revise the template and specify its location. I have copied the modified template into this repo, in order that anyone are able to re-compile my writings when seeing this repo, minimizing further complications.

To reduce potential conflicts between packages and enhance portability, I have only included a package whenever it is absolutely necessary. For example, the `\mathscr` is commonly used, which requires `mathrsfs` package. And I write in Chinese, which requires `xelatex` engine and `xeCJK` package.

## A Script for update

The `.bash_profile`, `.bashrc`, and `.vimrc` are saved in my home (`~`) as they should be, and I update them when I feel like to. I also stores the above-mentioned makefiles and shell scripts simply in my home. On the contrary, this repo is intended to be a passive backup of them, that is, I update the copies saved in home and copied them to the local repo from time to time, rather than directly update files in this repo. Thus a short script, `update.sh`, that automates the copying action is included in this repo. 
