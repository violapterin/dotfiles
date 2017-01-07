# Note on "solarized" and other color schemes for Vim
*Jan. 7, 2017*

This note first explains the basic idea of syntax highlighting in Vim, then describes my experience with several popular color schemes, reminds the reader several caveats, and points out the moral of the story. I will focus only on Vim opened in the terminal emulator iTerm2, rather than GUI version of Vim, for example gVim or MacVim. 

--------------------------------

To facilitate discussion, I now define several terminologies. 

In Vim, plain text, I say, is *parsed* with rules according to its file extension, so that *syntax items*, which are strings that match a certain pre-defined pattern. For instance, `new` is picked out as a c++ keyword that instructs the operating system to find a memory block of a certain size for sake of holding variables, and to report us its address. Vim's syntax files are responsible for parsing. For further information, see `:h syntax`. 

Afterwards, several syntax items belong to one of 16 syntax groups, all or which is intended to be colored the same. A function from syntax items to syntax groups is said a *syntax recognition*. For example, in a `.cpp` file the string `new` belongs to the syntax group "Statement". In particular, I say that an item is *trivially recognized*, if it is mapped to the `Normal` group, i.e., being ignored. 

How it is colored, however, depends on the *color scheme*. Following above example, `new` is colored bright yellow in Vim's "default" color scheme, but grass-green in "solarized". For our purpose, all relevant colors may be described in terms of a hex triplet; for example, `#ffff00` stands for yellow. In other words, the set consisting of all hex-triplet-represented color is a universal set. Then, I say, a function from syntax groups to hex triplets is a *color realization*. A realization is specified by a color scheme file with extension `.vim`. 

And furthermore, I say, a hex triplet is shown as a *physical color* on a computer monitor; for example, `#ffff00` is shown as a yellow color on the monitor. I call such map from hex triplets to physical colors to be a *display*. If a set of displayed physical colors is significantly different from the physical colors envisioned by the creator, they are said to be *displayed incorrectly*. 

If opened in a graphical user interface (GUI), for example gVim or MacVim, all hex triplets are able to be displayed, and we are done.

Meanwhile, in a terminal, I say that each of the 16 syntax group are *assigned* a hex triplet. What follows is split into two cases. 

If `termguicolors` is set true (i.e. with `set termguicolors`), I call this a *pallete assignation*. Then variables `guifg` and `guibg` are used. We set their values to be hex triplets, specifying the assignation. 

Nevertheless, iTerm2 (and Mac's native Terminal.app in recent years) can only display 256 hex triplets. These 256 numbers, I say, are *valid hex triplets*. A function from hex triplets onto valid triplets now must be applied, which must be identical if restricted to the set of valid triplets. I call such function a *degradation*. A realization, then, is a composition of assignation and degradation. 

But if `termguicolors` is set false (i.e. with `set notermguicolors`), I call this a *direct assignation*. Then variables `ctermfg` and `ctermbg` are used —— in such case, each group are in turn given a nonnegative integer. 

At this stage it is further split into two cases, according to whether `t_Co` (number of colors) is 16 or 256. If 16, such number ranges from 0 to 15, and is input to a 16-color ANSI palette. If 256, it ranges from 0 to 255, and is input to the 256-color "xterm" palette. Here, I say, a *palette* is a function from a collection of nonnegative integers to hex triplets. 

An ANSI palette is specified by the present terminal theme in the preferences, while the "xterm" palette is more or less identical in each terminal emulator, thanks to "xterm" standards. From above, we know in either of 16 or 256 cases, degradation is identical. 

In conclusion, let me say that a *syntax highlighting* is a tuple comprised of a parsing, a recognition, and a realization. Afterwards the highlighting is displayed as physical color.

I noticed it to be very hard to find these pieces of information correct and nicely summarized. I learn these only after having read dozens of Stack Overflow questions and whatever forum posts I searched. 

--------------------------------

Supposing the reader has a vague understanding of these concepts, I can now give an account of my personal quest of alternative Vim color scheme. Until not long ago, as I used iTerm2 and use Vim in terminal, I always chose "Tango Dark" theme (and automatically applying its palette) it provided, and applied the "default" scheme in `.vimrc`. They looked very great, and I had no intention to change. 

Nevertheless, starting from one version of iTerm2 (probably one having been released in Nov. 2016), the physical colors suddenly looked strange. What in the before had been realized as vivid red, became pale purple, and that had been dark blue, now bright as sky-blue. 

By then, I had no idea why. Looking back by now, I conclude that it is probably because "Tango Dark"'s ANSI palette is changed starting in newer versions. 
But afterwards I learnt that don't like the physical color under direct assignation, either —— though I should have known that if I had tried the direct assignation, I would have saw the same. 

Anyway, I decided to import a third-party scheme. To do so, one possible way, which I did, is to copy the downloaded `.vim` file that specifies the assignation, and to paste it into `~/.vim/colors/`. 
Alternatively, the whole repo in the GitHub page may be saved in `~/.vim/bundle`, so that a plugin manager may find it. 
With a manager, it is easier to update and remove packages. 

The most easy-to-use manager, I think, is Tim Pope's "Pathogen". 
To invoke it, include 

    execute pathogen#infect()`

in `.vimrc` before the `colorscheme` line. 

Several popular schemes I found were, in order of discovery: (listing GitHub repos)

* "solarized" from `altercation/vim-colors-solarized`
* "flattened" from `romainl/flattened` 
* "gruvbox" from `morhetz/gruvbox`
* "tomorrow" family of variants from `chriskempson/tomorrow-theme`
* "molokai" from `tomasr/molokai`

Ethan Schoonover's popular scheme "solarized" attempts to realize a collection of painstakingly chosen pastel colors both eye-comforting and readable. The underlying mechanism is unnecessarily complicated, and I did not go to great lengths. But below is how I understand it. 

If under palette assignation, "solarized" requires a suitable ANSI palette to ultimately display correctly. Thus "solarized" relies on the corresponding "Solarized" theme, and hence corresponding palette. Fortunately, the release of iTerm2 include the "Solarized" theme. With any other theme, it is to be realized and so displayed incorrectly. 

But if under direct assignation, none of the hex triplets being assigned is valid. As a result, iTerm2 is forced to perform degradation, and its judgement is poor. The result is a bunch of undefined behavior and incorrect realization. 

Thus motivated, Romain Lafourcade prepared a simplified version named "flattened" for sake of robustness. When under direct assignation, *it assigns hex triplets same as "solarized", but defines degradation function in case true colors are not feasible*. And when under palette assignation, it *assigns a number within the already standardized 256 xterm palette*, ensuring they are all valid, irrespective of ANSI palette. 

Similar can be said of all other schemes I listed. For direct assignation, they either *simply assign a hex triplets of a valid color, or assign an invalid triplet but specify degradation method themselves*. For palette assignation, it directly assigns a valid color in the xterm palette, which must be valid. They all work (though very slightly differently) with either palette or direct assignation. 

I suppose it is fair to say that the original "solarized", though carefully researched and customized, is ill-designed. 

--------------------------------

I don't deem myself having obsessive–compulsive personality disorder, but none of the color schemes is completely satisfactory. In particular, I shall remark on two file formats not strictly being programming languages: LaTeX (`.tex`) and Markdown (`.md`). Both, I use a lot —— I write in LaTeX reports or notes containing mathematics, and in Markdown personal and creative writings. Unfortunately, their recognition seems to be less well-prepared.

As I observe it, in a `.tex` file two syntax items are most frequently parsed: the enclosing delimiters (like `{}`), and backslash-appended commands (like `\lambda`). For one thing, "solarized" (or, following it, "flattened") recognizes both nontrivially. But "gruvbox", "molokai", and all of Vim's native schemes recognize only delimiters nontrivially. And each of "tomorrow"'s variants recognizes both trivially. 

In addition, among five schemes I listed, only "gruvbox" recognizes `.md` nontrivially. It then seems that in general "gruvbox" best recognizes syntax. 

--------------------------------

I find colors that "gruvbox" assigned is bright and easier to see, but are a bit too close and too identically "warm". And those of "solarized" are much more vivid, and bluish-green background may be good for the eyes, but most colors are dim. In particular, the `Ignored` item in the `Normal` group (see `:h syntax`) is difficult to read except with screen set to be the brightest. 

Since "solarized" is the first I tried, intending to fix this, I found the file "solarized.vim" long and cryptic, and not obvious where and how the `Normal` group is defined. And my attempts to set normal text in brighter by virtue of simply override in `.vimrc`, all failed.

Afterwards I discovered "flattened", which applies easier method to mix colors. In `flattened_dark.vim`, I chose a brighter grey, and set

    hi Normal guifg=#bac3c4

To choose the triplet, one may want to see 256 native colors of the present terminal. Scripts such as `mgedmin/show-all-256-colors.py` is handy. 

Lastly, "Solarized" theme also makes console output too dim, as is the case of normal text in Vim. To change it, in `~/.bash_profile`, to the line `export PS1=` which sets you personal prompt, please append `\[\033[1;37m\]` (escape sequence for pure white in the ANSI palette) at the end. 
At this point, I am more than satisfied.

--------------------------------

In short, copy `flattened.vim` into `~/.vim/colors/` folder, and in the file, substitute for `hi Normal guifg` a hex color code of brighter grey. After that, enjoy writing and coding in the lovely Vim for the rest of your life. And, oh, remember the lesson that it is better to design a product with reasonably good quality but reliable, like "flattened", rather than one extremely fine-tuned but hardly works, like "solarized".
