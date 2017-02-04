# Managing LaTeX packages and fonts
*Jan. 20, 2017*

## LaTeX Packages Made Easy

The original TeX compiler Professor Knuth wrote was written in PASCAL, and only specifies 

In theory, 

To start using LaTeX, 

For a Mac user like me the best bet is probably to install [MacTeX](http://www.tug.org/mactex/), a distribution for Mac including TeX Live, compilers, scripts, packages (i.e. libraries), and fonts.
When I compile a document, I may include a package I found someone using, that solves my needs.
Such management of package is taken care by Tex Live.

I cannot promise absolutely for sure that all packages I call in my templates are natively included in MacTex.
But as I observe the compiler's messages, at least it seems that the moment the compiler does not find it, Tex Live installs it.

Put simply, nothing I call in source code in my writing Indeed, I have the intention that I stick whenever possible to packages that is either 
This is deliberate, since I want to 

Windows users 
They may consult [MiKTeX's website](https://miktex.org/) for further information.

[The LaTeX Font Catalogue](http://www.tug.dk/FontCatalogue/)



    wget https://tug.org/fonts/getnonfreefonts/install-getnonfreefonts
    texlua install-getnonfreefonts-sys
    getnonfreefonts-sys --all

in which the 1st line downloads the script in question, the 2nd line runs it, and the 3rd line installs all fonts it provides, includes Garamond Expert.

Here comes the caveat. **Use `install-getnonfreefonts-sys`**, rather than `install-getnonfreefonts` as suggested in the site I just quote.

The reason, To quote one [TeX Stack Exchange answerer](http://tex.stackexchange.com/questions/255709/why-shouldnt-i-use-getnonfreefonts-to-install-additional-fonts-why-shouldnt-i), is that 

All packages included 
One less portable decision that my choice to use the 

    \usepackage{garamondx}% default font: Garamond
    \usepackage[garamondx,cmbraces]{newtxmath}% math supporting package

There was several variations of Garamond on [The LaTeX Font Catalogue](http://www.tug.dk/FontCatalogue/). As I recall, not everyone works with 

Except my choice to use the Garamond font, which requires additional toil.
This, then, is probably the least portable of my settings.
Indeed, it is not easy matter to specify, for the entire document, the default font typeface other than the default Computer Modern;
nor is it easy to locally change the font typeface, for such feature is not originally conceived as the scope of TeX


I first notice Garamond, or probably a variation Classical Dynamics of Particles and Systems by Marion and Thornton (Boston: Brooks/Cole Cengage Learning)
My infatuation with the Garamond font had cased me great trouble.

To set global 
Actually I had used `\usepackage[urw-garamond]{mathdesign}` for quite a long time, as suggested in 

Renditions by `mathdesign` is fancier, which I like better. 



, but there was some problems I vaguely remembers to be related to the restriction that, in plain TeX which LaTeX based on, only 16 math fonts may be declared. 
When I used `urw-garamond` in displaying formulae, a bug makes such quota used up, even though I have not. 

Such is life. Please use `newtxmath` instead.

To change font locally, such syntax shall be used:

    {
      \fontfamily{qcr} \selectfont These words are in Courier.
    }

typeface is a consistent visual appearance or style which can be a "family" or related set of fonts. 
To be precide, let me restate the distinction between a font and a typeface. A *font* is a specific member the family such as roman, boldface, or italic type, while 
For example, Adobe Garamond is a typeface, while Adobe Garamond bold italic is a font beloning to the typeface. 

## Appendix: Installing other Fonts than Computer Modern

This table is taken from a ShareLaTeX article [Font typefaces](https://www.sharelatex.com/learn/Font_typefaces). 
It is not easy matter to find the fontcode. 
Since Computer Modern is default, no package is needed.
But to set another font as default, the user has to include related packages and 

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

