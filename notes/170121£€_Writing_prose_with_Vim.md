# Writing Prose with Vim: Wrapping and Other Headaches
*Jan. 21, 2017*

This note first discusses the wrapping problem. I observe the consequence of soft and hard wrap, and their pros and cons. Afterwards I shall add several unrelated remarks on configurating Vim run in a terminal emulator, for easier prose writing experience.

## Motivation

The present concerns are urged by my decision to use plain text to save my pieces of prose in Markdown. They are in turn edited with Vim, since, in the past four months or so, I have grown gradually accustomed with Vim, and have started to like it. Still, attempt to write and edit prose, rather source code, in Vim, leads to a number of behavior somewhat less than desired, and the they are related to wrapping of text.

## Terminology

Before discussing the wrapping problem, I assume the reader has a basic familiarity with Vim. (If you do not, please do yourself a favor and give it a try.) And I now define several terms.

A *window* is the part of monitor used to display text. If toggled full screen, the window is all of the monitor; if `:vsp` (vertical split) is run, the window is half of the monitor. A *frame* is the present-visible part of the text file.

I say a *physical line* is an ordered collection of characters deliminated by end-of-lines (EOL); see another note of mine, "End-of-line Characters". On the contrary, a *apparent line* is an order collection of characters displayed in a single row in the current window.

I say a plain text file is *softly-wrapped* if physical lines are allowed to be longer than current window width. And, on the other hand, I say a plain text file is *hard-wrapped* if such EOL have been inserted that no physical line is longer than current window width.

A compiler is said to *weakly render the EOL* if a single EOL in the source is ignored. Meanwhile, a compiler is said to *strongly render the EOL* if a single EOL in the source is rendered a newline in the binary executive. Both a weakly- and strongly-rendering compilers render two consecutive EOL the beginning of new paragraph.

## Editing Softly-Wrapped Text with Vim

I just distinguished two styles of writing prose in plain text, namely soft wrap and hard wrap. And one will soon find it cumbersome in several aspects to edit soft wrapped text in Vim.

Indeed, by a "line" Vim means a physical line, and in a soft-wrapped piece of prose, a physical line is a paragraph. The result is a file with very long physical lines and blank lines alternating each other.

### Navigation

In Vim, `j` and `k` stand for navigation in terms of physical lines, while `gj` and `gk` the same in terms of apparent lines. Thus the first inconvenience the user may experience is that, in a piece of prose, we normally intend the action of `gj` and `gk`, and may still occationally need `j` and `k`. Thus we may map `j` to `gj`, and `k` to `gk`, and conversely `gj` to `j`, and `gk` to `k`.

### Displaying Lines Not Fully Shown

Another irritation is that, in the very end of the current window, there may be some space shorter than the next line; in this case, the next line is not shown and such space is wasted. This effectively makes my window (already being split) quite small. 

A partial workaround is to toggle between displaying the next line as much as possible, and not displaying altogether:

    noremap <silent> <leader>\ :call ToggleDisplayLastLine()<cr>

the function `ToggleDisplayLastLine()` is implemented as thus:

    function! ToggleDisplayLastLine()
        if (&display=='')
            let &display='truncate'
        else
            let &display=''
        endif
    endfunction

### Scrolling

Moreover, it is awkward to scroll either for half frame (`<ctrl>u` and `<ctrl>d`) or a whole frame (`<ctrl>f` and `<ctrl>b`).

Half of the window, on one hand, does not correspond to many lines, because every physical line now consists of too many apparent lines.

On the other hand, it is difficult to estimate by one's "mind-map" for frames because a "half frame" now is often much less than half of a window, with some rows wasted in the manner pointed above.

As for whole-frame scrolling, Vim reserves 2 lines, and repeats them both in the previous and the present frame. Now that the next frame is really the "next frame", but with substantial shift, since a paragraph is long. This makes the user harder to visualize the new position which it is.

Before long I have make it a habit to always scroll for whole frame, and map:

    nnoremap <c-f> <c-f><c-e><c-e>M
    nnoremap <c-b> <c-b><c-y><c-y>M

### Line Numbers

But a final complain remains unresolved, that is line numbers. Line numbers are crucial in navigating, for example `gg20` (jumping to line 20), `:5,10s/good/bad/g` (replacing "good" with "bad" from line 5 to line 10), or even before executing `10dd` (cutting 10 lines starting from cursor position) one takes a look at line numbers and decides how many lines are to be copied.

The line numbers in Vim, however, is also counted according to physical lines. Since now it is really paragraph number, such information is not particularly helpful. In contrast, in Microsoft Word apparent line numbers many be shown, and such feature is more convenient.

## Considering Hard Wrap

I am not the first one aware of the problem. Many Vim lovers, as I have searched, too proposed their solutions, and some of them, I have tried. The answer vary, but most suggest hard wrap.

The user puts as many words as can be in every physical line before, for example, 74 characters is reached. This may be done automatically in Vim with

    set textwidth=74

The reader may want to check `formatoptions` (see `:h fo-table`) for detailed settings. The default `tcq` (see `:h formatoptions`). Here `t` auto-wraps text using `textwidth`, `c` does the same for code comments, and `q` allows formatting of comments with `gq`.

Unfortunately, when I rearrange material, the physical lines become uneven. Then I cannot estimate the number of words from a block of text, because end of apparent lines are uneven. And such estimation is important, as such visual cues suggest hint me instantly, from the amount of words, whether a paragraph is too long, which I should break, or it is too short, which I should combine with adjacent paragraphs.

## Re-formatting in Real Time

To make ends of visual lines even, there is a automatically re-formatting command `gqap`, but it only applies to the current paragraph. Maybe the user can define a shortcut for this, but reformatting still need to be done when typing, which is a nuisance.

More problematically, this doesn't work for Chinese characters. The command `gqap` changes nothing. Maybe it is possible, with some Vimscript, to tell Vim what a paragraph in Chinese is, but I don't know how.

But for the moment let us bypass the point by assuming there is a convenient way to work with hard wrapped prose, and that hard wrapped text is visually satisfying to the user.

Even so, what if I want to copy and paste my prose into somewhere else, like Wordpress or Facebook, where text are strongly rendered? The paragraphs, once hard wrapped, are not easily converted back to soft wrapped ones.

[Luke Maciak](http://www.terminally-incoherent.com/blog/2013/06/17/using-vim-for-writing-prose/) recommands

    :%norm vipJ

But the result is horrible. Indented code blocks get merged with preceding and following paragraphs (even with a blank line separating each of them), and so are shorter paragraphs swallowed.

## Compilation: Four Possibilities

Moreover, there seems to be some controversy about whether EOL is rendered weakly or strongly by compilers. In fact, I have deliberately avoid the problem in the above. 

Indeed, the prose written in plain text is sort of source code that need to be interpreted in order to published, even though we do not normally think this way. The point here is that LaTeX compilers always render the EOL weakly, but some Markdown compilers render the EOL weakly, some strongly.

Actually, [Gruber's original specification](https://daringfireball.net/projects/markdown/syntax) does not resolve parsing issue unambiguously, and GitHub, Pandoc, WordPress, and so on, all give their own implementation. Such disorder motivates [CommonMark](http://commonmark.org), the effort to standarize Markdown.

Grober hints weak rendition in his spec (same link as above):

>The implication of the “one or more consecutive lines of text” rule is that Markdown supports “hard-wrapped” text paragraphs. This differs significantly from most other text-to-HTML formatters \[...\] which translate every line break character in a paragraph into a `<br />` tag.

And it is true that [GitHub](http://rmarkdown.rstudio.com/authoring_pandoc_markdown.html), [Pandoc](http://rmarkdown.rstudio.com/authoring_pandoc_markdown.html), [Stack Overflow](http://stackoverflow.com/editing-help), and [CommonMark Spec](http://spec.commonmark.org/0.27/#hard-line-breaks) all render EOL weakly.

Unfortunately, WordPress and early GitHub render EOL strongly, showing the concern that availble Markdown compilers may still remain inconsistent. For the former, see WordPress's [Markdown quick reference](https://en.support.wordpress.com/markdown-quick-reference/). For the latter, compare [this Meta Stack Exchange question](http://meta.stackexchange.com/questions/26011/should-the-markdown-renderer-treat-a-single-line-break-as-br) and debate there.

Thus there are four cases:

1. Text hard wrapped, EOL weakly rendered.
2. Text hard wrapped, EOL strongly rendered.
3. Text soft wrapped, EOL weakly rendered.
4. Text soft wrapped, EOL strongly rendered.

Cases (1) and (4) are desired. But (3) also produces the same result. Meanwhile, (2) fixes text width in output, making typesetting inflexible. For the case of PDF, if the text width is less than page width the margin may be wider than conceived, and if it is more than page width each line will be incorrectly wrapped.

Notice however that soft wrap is unaffected in both cases (3) and (4). After all, soft wrap avoids single EOL, in which weak and strong rendition differs.

The practice of hard wrap also violates the principle of Markdown somewhat. The original design of Markdown intends that even the source should be easy to read. But hard wrap isn't something that laypeople (maybe one know only Microsoft Word) will spontaneously do. It is fair to say hard wrap makes no semetic sense, and is artificial.

One user-submitted Wikipedia [guideline](https://en.wikipedia.org/wiki/Wikipedia:Don%27t_use_line_breaks) (retrieved as of Feb. 2017) also raise a similar point against hard wrap. Wiki-markup interpreter also renders EOL weakly. The guideline continues to stress that hard wrap create a number of difficulties in that they have to be removed before a numbered list or bullet point is added. Although Wiki-markup is different from Markdown, these criticisms also applies here.

## Hard Wrap at Every End of Sentence

A compromised way is to insert EOL at every end of sentence; I may call this *halfway wrap*. This way, every physical line is a sentence, which is a meaningful entity. It thus makes sense to go up, go down, cut, and paste an entire line.

But the method of halfway wrap again makes ends of apparent lines uneven, and I have argued above that such estimation plays important role in writing.

Still, even writing Markdown, I find it useful to halfway wrap, when I am in the stage of sketching. Halfway wrap makes it easy to assemble material by cutting or pasting an entire physical line. Afterwards, I remove EOLs between physical lines by visual selecting and `J` when writing in English, or `gJ`, in Chinese.

## Returning to Soft Wrap

After a long comtemplation on the matter, I decide to return to the original habit: I will always halfway-wrap TEX sources, but softly-wrap Markdown sources. 

The case for Markdown is different from that of LaTeX. Even though both render EOL weakly, I always see compiled pdf on the facing side, using for example TeXstudio, but view only Markdown source when working on it. Thus I want Markdown sources to visually resemble the output, but that is not necessary the way I work LaTeX .

As I see it, the best solution is that Vim show *apparent line numbers*, rather than *physical line numbers*.  I hope future Vim will be able to do these.

No wonder, this behavior is contrary to Vim's design—a "line editor". All of Vim's commands deal with the file in a line-by-line basis. But, to cater both code-writers and prose-writers, there may even be a setting that toggles line numbers between them. Or specification on which is used, may be saved in a "modeline", that is, the first and last few lines of a file. If, like in Microsoft Word, a fairly large, warped arrow appears where a EOL is, hard and soft wrap may be easily disginguished visually, and it will not be confusing to recognize which kind of line number is shown at the moment.

Argurably, if in an piece of prose the majority of paragraphs are too long to be properly worked with in Vim, these paragraphs are probably too long.

If iTerm's window fits the screen, as I count it, a split window can show at most 74 halfwidth characters such as ASCII characters, or equivalently, 37 fullwidth characters such as Chinese and Chinese punctuations. The height of window can fit 33 lines if none is wrapped. This amounts to 2442 halfwidth or 1221 fullwidth characters. A paragraph as long as half of the capacity of the present window is probably too long. That is at most 610.5 characters or so.

That said, it is still unsatisfying that scrolling is not smooth, but a new frame must start with a displayed line of a paragraph (physical line) too. In word or TextEdit, this need not be true, but the first displayed line of a new frame may be any displayed line in any paragraph.

## Other Tips

Having discussed the problem of wrapping, I shall share several configurations and practices that, I find, make it easier to write prose in Vim.

### Switching Input Source

The most used key in Vim, without doubt, is the Escape key, which returns to the normal mode.

And for a Chinese user, like me, the second most used function is also clear: switching input source between a Chinese input source (whatever is used) and ASCII input source. Thus the user is likely to find it cumbersome to switch mode in Vim in such requirement.

Indeed, to type one or more Chinese characters, he has to hit `i` (insert mode), switch to Chinese keyboard, type, switch back to US keyboard, and hit escape. Such toil, unfortunately, nearly cancels the efficiency gained by Vim's modal design.

It seems best to set both Escape and the input-switching key (or key combination) to be something close to the home row (the resting positiong where `F` and `J` are). Though Sierra (by the time latest version of Mac OS) allows the user to toggle between two input sources by Caps Lock (see System Preferences > Keyboard > Input Sources), I already map Caps Lock as Escape (which is also possible only Sierra by System Preferences > Keyboard > Keyboard > Modifier keys). And even if I set Caps Lock as the switch, still I have to set another key near to the home row to be Escape, but Sierra only allows me to set either Shift, Option, or Command as Escape, and each possibility is impractical.

Fortunately, I found Karabiner Elements, which makes it possible to remap keys. Karabiner Elements works by forcing the physical key `X`'s signal to be interpreted as key `Y`'s function. 

Its precursor is [Karabiner](https://pqrs.org/osx/karabiner/index.html.en), which previously was out of order in Sierra. But the team produced a version called [Karabiner Elements](https://github.com/tekezo/Karabiner-Elements) for Sierra; here is the [latest compiled image](https://pqrs.org/latest/karabiner-elements-latest.dmg). 

This is my setting. Physical Caps Lock now performs the function of Escape, and Escape that of `` `/~ ``, and `` `/~ `` that of Tab, and Tab that of F5 (or any seldom used function key; `F5` in Sierra dims the keyboard lighting), and `F5` that of Caps Lock.

Then I set `F5` to switch to the previously-used input source. I am proud of my setting. Vim users for non-Latin family language will save considerable effort with this!

### Displaying Halfwidth and Fullwidth Characters

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

The choice of non-ASCII font need some justification. Such choice effectively shows ASCII in 14pt Monaco, ELC in 15pt PT Mono, and CC in 15pt PingFang SC Regular.

Why is it so? In fact, I guess it is because when a specified font does not cover the present character, Mac replaces the font with a similar styled font. So, if it is not required that non-ASCII text shall be shown in another font, Mac show CC in ST Heiti. In the beginning I set non-ASCII font to be PingFang SC, since I like it. But I soon find some ELCs too wide, wider than halfwidth.

After some trial and error, I discovered that PT Mono applied to ELCs looks good, and furthermore it leaves CC applied to PingFang SC, and all is well. How did it take me so long to discover this, all these months tolerating eye-strainingly thick Sans fonts!

I also recommend to tick those boxes to introduce more variety in font.

* Draw bold text in bold font 
* Draw bold text in bright color
* Italic text allowed

As for Vim, stick to the default `set ambiwidth=single`, and do not set it `double`.

In the beginning I heard it said on some forum that CC expects fullwidth and requires `set ambiwidth=double` to be displayed correctly (see `:help ambiwidth`). But I consider it not true. Either Vim or MacVim running in either Terminal.app or iTerm2 already displays CC correctly with `ambiwidth=single`. (I suppose same is true for Japanese and Korean, but I know neither, and haven't tried.)

In fact, when previously I set it `double`, I find the following ELCs displayed in fullwidth also: `ß` and `ü` used in German, and ligature `Œ` and `œ` and Norwegian vowel `ø`, and some special symbols like Euro `€`, section sign `§`, and pilcrow `¶`.

The fact may be related to the observation said above that some CC fonts renders some ELCs wider than halfwidth. In these fonts, ELCs just mentioned may be better shown in fullwidth than in halfwidth.
