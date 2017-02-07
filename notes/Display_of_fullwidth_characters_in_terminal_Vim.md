# Display of Fullwidth Characters in Terminal Vim
*Feb. 7, 2017*

The following settings, as I see, makes iTerm2 properly and pleasingly display ASCII characters (hereafter ASCII), several extended Latin charactes (hereafter ELC), and both traditional and simplified Chinese characters and related symbols such as punctuation marks (hereafter CC). In the following, *halfwidth* means the width of ASCII, and *fullwidth* twice as wide. In iTerm2, a fullwidth is almost a square.

Tick those boxes concerning display:

* Use thin strokes for anti-aliased text: "Always"
* Use HFS+ Unicode normolization (better fidelity but slower)
* Use a different font for non-ASCII text
* Anti-aliased [for ASCII text]
* Anti-aliased [for non-ASCII text]

Anti-aliasing makes strokes smoother, but too thick, thus we tell iTerm2 to use thin strokes, mitigating this effect.

I set these fonts:

* 14pt Monaco as default ASCII font
* 15pt PT Mono for non-ASCII text

The choice of non-ASCII font needs justification. It makes ASCII shown in 14pt Monaco, ELC in 15pt PT Mono, and CC in 15pt PingFang SC Regular.

Why is it so? In fact, I guess it is because, whenever a specified font does not cover the present character, Mac applies to it a similar styled font. So, if it is not specified that non-ASCII text shall be shown in another font, by default Mac will show CC in ST Heiti.

Previously I set non-ASCII font to be PingFang SC, since I like it. But I soon find some ELCs too wide, wider than halfwidth. After some trial and error, I discovered that PT Mono applied to ELCs looks good, and furthermore it leaves CC applied to PingFang SC, and all is well. How did it take me so long to discover this, all these months tolerating eye-strainingly thick Sans serif fonts!

I also recommend to tick those boxes to introduce more variety in font.

* Draw bold text in bold font 
* Draw bold text in bright color
* Italic text allowed

As for Vim, stick to the default `set ambiwidth=single`, and do not set it `double`.

In the beginning I heard it said somewhere that CC expects fullwidth, and thus requires `set ambiwidth=double` to be displayed correctly (see `:help ambiwidth`). But I this is not the case. Either Vim or MacVim running in either Terminal.app or iTerm2 already displays CC correctly with `ambiwidth=single`. (I suppose same is true for Japanese and Korean, but I know neither, and haven't tried.)

In fact, when previously I set it `double`, I find the following ELCs displayed in fullwidth also: `ß` and `ü` used in German, and ligature `Œ` and `œ`, and Norwegian vowel `ø`, and some special symbols like Euro `€`, section sign `§`, and pilcrow `¶`.

The fact may be related to the observation said above that some CC fonts renders some ELCs wider than halfwidth. I guess that, in these fonts, ELCs just mentioned will be better shown in fullwidth than in halfwidth.
