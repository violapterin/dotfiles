# Managing LaTeX packages and fonts
*Jan. 20, 2017*

## The TeX Family

TeX is a competent language for typesetting tasks, but for average readers, sophisticated TeX code is still necessary to implement relatively easy purpose. This is the reason LaTeX, a collection of packages (libraries) came out to wrap TeX, so readers may call packages to simplify their sources, making it easier to write, more robust to run, and more resistant to change.

Unfortunately, the original `pdftex` does not support UTF-8 characters (such as umlauts, Chinese, and other non-Latin languages). Both `xetex` and `luatex` compensate this flaw by accepting UTF-8 characters natively. The `xetex` is an extension to the original `tex` engine, keeping the original WEB codebase. Meanwhile `luatex` is a new implementation of TeX written in C.

Furthermore, while many of the plain TeX commands are not allowed for `pdflatex` users, `lualatex` has the advantage that users are not insulated from plain TeX commands. When symbolic links `pdflatex`, `xelatex`, and `lualatex` are called respectively, they call binaries `pdftex`, `xetex`, and `luatex` respectively and afterwards load LaTeX packages. As you can see, their names have caused a lot of confusion between formats and engines.

By the way, ConTeXt is another well-acclaimed collection of packages, having status comparable to LaTeX, but has never really caught on. Historically, the earlier version (Mark I) of ConTeXt first worked with Knuth's `dvi`-outputting engine, then (Mark II) with `pdftex`. The present version (Mark IV) always goes with `luatex`.

## Auto Installation of LaTeX Packages

The remaining of this note will focus on the LaTeX format (that is, what `pdflatex` accepts) only. To use a LaTeX command, in theory the relevant `.sty` files have to be placed in the same directory as the source of document. However, for a Mac user like me the best bet is probably to install [MacTeX](http://www.tug.org/mactex/), a distribution for Mac including TeX Live, compilers, scripts, packages, and fonts. When I compile a document, I only have to declare the inclusion of the package, leaving its management of package to be taken care by Tex Live.

It is easy to install MacTeX. Just open the `.pkg` file, and follow the instructions. But if you want to uninstall existent version, you have to use command line. All related files are stored in 
`/usr/local/texlive/2016` and `~/Library/texlive/2016`. Just delete them with `rm -rf`. The former requires `sudo` privilege, while the latter does not.

With TeX Live, it is easy to manage packages. As I observe the compiler's messages, it seems that whenever the compiler does not find a package, Tex Live installs it immediately. Indeed, I have the intention that I stick whenever possible to standard packages that come with MacTeX, in order to enhance compatibility for future readers. (I am not sure, though, whether all packages I call in my templates are natively included in MacTeX.)

Windows users may consult [MiKTeX's website](https://miktex.org/) for further information, though I haven't studied and suppose to be similar.

## Getting Non-Free Fonts

While packages are managed automatically by a standard distribution if it includes them, it is in general cumbersome to change font, globally or locally, into something other than the default Computer Modern, because such feature was not originally conceived to be the scope of TeX.

The desire to change font was urged by my choice to use the Garamond font when compiling with `pdflatex`. This turned out way more tiresome than I thought. 

I first noticed the idiosyncrasy of Garamond in *Classical Dynamics of Particles and Systems* by Marion and Thornton (Boston: Brooks/Cole Cengage Learning). Looking back at that, I believe it is a variant of Garamond. I was in love with it at once. My infatuation with Garamond had given me great trouble. This font-changing part, then, is probably the least portable of my settings.

The below instructions apply to `pdflatex` only. First we have to install "non-free fonts". To quote the [TeX Users Group](https://www.tug.org/fonts/getnonfreefonts/),

>Some font suppliers provide fonts which can be used freely but they disallow charging money for the distribution. \[...\] `getnonfreefonts` is a script which downloads and installs these fonts.

Open your terminal and copy and paste

    wget https://tug.org/fonts/getnonfreefonts/install-getnonfreefonts
    texlua install-getnonfreefonts-sys
    getnonfreefonts-sys --all

in which the 1st line downloads the script in question, the 2nd line runs it, and the 3rd line installs all fonts it provides, including Garamond Expert.

Here comes the caveat. **Use `install-getnonfreefonts-sys`**, rather than `install-getnonfreefonts` as suggested in the site I just quote.

The reason, to quote one [TeX Stack Exchange answerer](http://tex.stackexchange.com/questions/255709/why-shouldnt-i-use-getnonfreefonts-to-install-additional-fonts-why-shouldnt-i), is that `install-getnonfreefonts` calls updmap, which in turn

>creates personal font mapping files which are not updated when fonts are removed, added or updated for the system-wide installation of TeX Live.

## Changing Font Globally

Having installed relevant packages, we have to find the usage of that font in question. The following method works for `pdftex` only, not for `xetex` or `luatex`. We first consider to change font globally, that is throughout the whole document. A good reference is [The LaTeX Font Catalogue](http://www.tug.dk/FontCatalogue/). For example, there was several variations of Garamond on [The LaTeX Font Catalogue](http://www.tug.dk/FontCatalogue/). As I recall, not everyone works with mathematical formulae. One that works reads (comments being mine)

    \usepackage{garamondx}% default font: Garamond
    \usepackage[garamondx,cmbraces]{newtxmath}% math supporting package

Actually, previously I had used `\usepackage[urw-garamond]{mathdesign}` for quite a long time, as suggested in another page. Renditions by `mathdesign` is fancier, which I like better. But I soon found that there were some problems I vaguely remember to be related to the restriction that, in plain TeX which LaTeX based on, only 16 math fonts may be declared. When I used `urw-garamond` in displaying formulae, a bug used up such quota, even though I had had declared nothing.

Such is life. Please use `newtxmath` instead.

## Changing Font Locally

To change font locally, such syntax shall be used:

    { \fontfamily{lmtt} \selectfont These words are in Latin Modern Typewriter. }

To understand this line, we distinguish the concept *typeface* and *font*. A typeface is a consistent visual appearance or style across a set of fonts. This is controlled by `\fontfamily` in TeX. A *font* is a specific member in a typeface, which belongs to a family such as roman, boldface, or italic. This is controlled by `\fontseries` and `\fontshape` in TeX. For example, "Adobe Garamond" is a typeface, while "Adobe Garamond Bold Italic" is a font belonging to the typeface.

The above line changes the "typeface" to `lmtt`, a fontcode meaning Latin Modern Typewriter. The fontcode must be looked up first. You can apply `\bfseries` or `\itseries` besides that.

You may also overwrite a existent command such as `\textrm`, `\texttt`, or `\textsf` (I am sorry for the bewildering terminology). For example, if you want all typewriter text to be in Latin Modern Typewriter, you may redefine `\texttt` with

    \renewcommand*\ttdefault{lmtt}% typewriter font: Latin Modern Typewriter

Afterwards, you just use the built-in `\texttt`.

## Table of Font Packages and Codes

It is not easy matter to find the fontcode and relevant package you have to install in advance. This table is excerpted from a ShareLaTeX article [Font typefaces](https://www.sharelatex.com/learn/Font_typefaces). You can see that, since Computer Modern is default, no package is necessary.

* **Font** / **necessary package name** / **fontcode**
* Bookman / `bookman` / `pbk`
* Charter / `charter` / `bch`
* Computer Modern Roman / (no need) / `cmr`
* Computer Modern Sans Serif / (no need) / `cmss`
* Computer Modern Typewriter / (no need) / `cmtt`
* Courier / `courier` / `pcr`
* Helvetica / `helvet` / `phv`
* Latin Modern Dunhill / `lmodern` / `lmdh`
* Latin Modern Roman / `lmodern` / `lmr`
* Latin Modern Sans Serif / `lmodern` / `lmss`
* Latin Modern Sans Typewriter / `lmodern` / `lmtt`
* Palatino / `palatino` / `ppl`
* TEX Gyre Adventor / `tgadventor` / `qag`
* TEX Gyre Bonum / `tgbonum` / `qbk`
* TEX Gyre Cursor / `tgcursor` / `qcr`
* TEX Gyre Heros / `tgheros` / `qhv`
* TEX Gyre Pagella / `tgpagella` / `qpl`
* TEX Gyre Schola / `tgschola` / `qcs`
* TEX Gyre Termes / `tgtermes` / `qtm`
* Times / `times` / `ptm`
* Utopia / `utopia` / `put`

## CJK compatibility of Other Engines

To type CJK (Chinese, Japanese, or Korean) characters, if with `xetex`, the package `xeCJK` is generally recommended. Similarly, the package do the same for `luatexja` for `luatex`. It is said that `xeCJK` supports Chinese typesetting well, but is poor in rendering Japanese and Korean. And some claim that, while `luatexja` is designed by a Japanese team, the output for Chinese is somewhat unconventional. I have not tried `luatexja`.

As I have perceived, `pdflatex` is the fastest, `xelatex` usually slower, and `lualatex` often incredibly slow. I suppose that the principle of least complexity (both in time and in source) dictates that I use `pdflatex` whenever possible. Thus I use `pdflatex` when working on a purely-Latin source. Only if there are Chinese or other UTF-8 characters, shall I use `xelatex`. 

Be careful that, since their libraries are also different, you may well define a macro of your own, whose name clashes (say) with a command for `xelatex`, but such clash does not happen with `pdflatex`. In such case, you should use `\newcommand` for that macro if compiling with `pdflatex`, but `\renewcommand`, if with `xelatex`. It is often troublesome to find the cause.
