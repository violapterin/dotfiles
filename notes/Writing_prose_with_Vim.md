# Writing Prose with Vim: The Wrapping Problem
*Jan. 21, 2017*

This note first discusses the wrapping problem. I observe the pros and cons of both soft and hard wrap.

The present concerns are urged by my decision to use plain text to save my pieces of prose in Markdown. They are in turn edited with Vim, since, in the past four months or so, I have grown gradually accustomed with Vim, and have started to like it. Still, attempt to write and edit prose, rather source code, with Vim, leads to a number of difficulties related to wrapping of text.

## Terminology

Before discussing the wrapping problem, I assume the reader has a basic familiarity with Vim. (If you do not, please do yourself a favor and give it a try.) And I now define several terms.

A *window* is the part of monitor used to display text. If toggled full screen, the window is all of the monitor screen; if `:vsp` (vertical split) is run, the window is half of the screen. A *frame* is the present-visible part of the text file.

I say a *physical line* is an ordered collection of characters delimited by end-of-line (EOL); see another note of mine, "End-of-line Characters". On the contrary, a *apparent line* is an ordered collection of characters displayed in a single row in the current window.

I say a plain text file is *softly-wrapped* if physical lines are allowed to be longer than current window width. And, on the other hand, I say a plain text file is *hard-wrapped* if such EOL have been inserted that no physical line is longer than current window width.

A compiler (or interpreter) is said to *weakly render the EOL* if a single EOL in the source is ignored. Meanwhile, a compiler is said to *strongly render the EOL* if a single EOL in the source is rendered a newline in the binary executive (or visual output). Both a weakly- and strongly-rendering compilers render two consecutive EOL the beginning of new paragraph.

## Editing Softly-Wrapped Text with Vim

I just distinguished soft wrap and hard wrap. One will soon find it cumbersome in several aspects to edit soft wrapped text with Vim.

Indeed, by a "line" Vim means a physical line, and in a soft-wrapped piece of prose, a physical line is a paragraph. The result is a file with very long physical lines and blank lines alternating each other.

### Navigation

In Vim, `j` and `k` stand for navigation in terms of physical lines, while `gj` and `gk` the same in terms of apparent lines. Thus the first inconvenience the user may experience is that, in a piece of prose, we normally intend the action of `gj` and `gk`, and may still occasionally need `j` and `k`. Thus we may map `j` to `gj`, and `k` to `gk`, and conversely `gj` to `j`, and `gk` to `k`.

### Displaying Lines Not Fully Shown

Another irritation is that, in the very end of the current window, there may be some space shorter than the next physical line; in this case, that physical line is not shown and such space is wasted. This effectively makes my window (already being split) quite small. 

A partial workaround is to toggle between displaying the next line as much as possible, and not displaying altogether:

    noremap <silent> <leader>\ :call ToggleDisplayLastLine()<cr>

where the function `ToggleDisplayLastLine()` is implemented as thus:

    function! ToggleDisplayLastLine()
        if (&display=='')
            let &display='truncate'
        else
            let &display=''
        endif
    endfunction

### Scrolling

Moreover, it is awkward to scroll either for half frame (`<ctrl>u` and `<ctrl>d`) or a whole frame (`<ctrl>f` and `<ctrl>b`).

As for half-frame scrolling, in fact, half of the window does not correspond to many lines, because every physical line now consists of too many apparent lines. Furthermore, a "half frame" now is often much less than half of a window, with some rows wasted in the manner pointed above.

As for whole-frame scrolling, Vim reserves 2 lines, and repeats them both in the previous and the present frame. Now, "scrolling a whole frame" does not really shows the "next frame", but the next frame with substantial shift, since a paragraph is long.

In both case, it is difficult to visualize the new position after scrolling.

Before long I have made it a habit to always scroll for whole frame, and have mapped:

    nnoremap <c-f> <c-f><c-e><c-e>M
    nnoremap <c-b> <c-b><c-y><c-y>M

This is easier to visualize, since the previous and the next frame does not overlap, just like pages in a book.

### Line Numbers

But a final complain remains unresolved, that is line numbers. Line numbers are crucial in navigating, for example `gg20` (jumping to line 20), substitution, for example `:5,10s/good/bad/g` (replacing "good" with "bad" from line 5 to line 10), or even the decision made before executing `10dd` (cutting 10 lines starting from cursor position), when the user takes a look at line numbers and estimates how many lines are to be copied.

The line numbers in Vim, however, is also counted according to physical lines. Since now it is really twice of the paragraph number, such information is not particularly helpful. In contrast, in Microsoft Word apparent line numbers many be shown, and such feature is more convenient.

## Considering Hard Wrap

I am not the first one aware of the problem. Many Vim lovers, as I have searched, too proposed their solutions, and some of them, I have tried. The answer vary, but most suggest hard wrap.

The supporters for hard wrap might hold that it is not the source code that matters, but the output. Indeed, the prose written in plain text is sort of source code that has to be interpreted in order to be published, though we don't normally think this way. I will say more of this below.

The user puts as many words as can be in every physical line before (for example) 74 characters is reached. EOL will be inserted automatically with

    set textwidth=74

The reader may want to check `formatoptions` (see `:h fo-table`) for detailed settings. The default is `tcq` (see `:h formatoptions`). Here `t` auto-wraps text using `textwidth`, `c` does the same for code comments, and `q` allows formatting of comments with `gq`.

Unfortunately, when I rearrange material, the physical lines become uneven. Then I cannot estimate the amount of words from a block of text, because end of apparent lines are uneven. But such estimation is important, for such visual cues suggest hint me instantly whether a paragraph is too long, which I should break, or it is too short, which I should combine with adjacent paragraphs.

## Re-formatting in Real Time

To make ends of visual lines even, there is a automatically re-formatting command `gqap`, but it only applies to the current paragraph. Maybe the user can define a shortcut for this, but reformatting still needs to be done when typing, which is a distraction.

More problematically, this doesn't work for Chinese characters. For them, the command `gqap` changes nothing. Maybe it is possible, with some Vimscript, to tell Vim what a paragraph in Chinese is, but I don't know how.

But for the moment let us bypass the point by assuming there is a convenient way to work with hard wrapped prose, and that hard wrapped text is visually satisfying to the user.

Even so, what if I want to copy and paste my prose into somewhere else, like WordPress or Facebook, where EOL is strongly rendered? The paragraphs, once hard wrapped, are not easily converted back to soft wrapped ones.

[Luke Maciak](http://www.terminally-incoherent.com/blog/2013/06/17/using-vim-for-writing-prose/) recommends

    :%norm vipJ

But the result is horrible. Indented code blocks get merged with preceding and following paragraphs (even with a blank line separating each of them), and shorter paragraphs are swallowed too.

## Compilation: Four Possibilities

Moreover, there seems to be some controversy about whether EOL is rendered weakly or strongly by Markdown compilers. Though LaTeX compilers always render the EOL weakly, but some Markdown compilers render the EOL weakly, some strongly. This fact, I have deliberately avoid addressing in the above.

Actually, [Gruber's original specification](https://daringfireball.net/projects/markdown/syntax) does not resolve parsing issue unambiguously, and GitHub, Pandoc, WordPress, and so on, all give their own implementation. Such disorder motivates [CommonMark](http://commonmark.org), the effort to standardize Markdown.

For one thing, Grober hints weak rendition in his spec (same link as above):

>The implication of the “one or more consecutive lines of text” rule is that Markdown supports “hard-wrapped” text paragraphs. This differs significantly from most other text-to-HTML formatters \[...\] which translate every line break character in a paragraph into a `<br />` tag.

And it is true that [GitHub](http://rmarkdown.rstudio.com/authoring_pandoc_markdown.html), [Pandoc](http://rmarkdown.rstudio.com/authoring_pandoc_markdown.html), [Stack Overflow](http://stackoverflow.com/editing-help), and [CommonMark Spec](http://spec.commonmark.org/0.27/#hard-line-breaks) all render EOL weakly.

Unfortunately, WordPress and early GitHub render EOL strongly, showing the concern that available Markdown compilers may still remain inconsistent. For the former, see WordPress's [Markdown quick reference](https://en.support.wordpress.com/markdown-quick-reference/). For the latter, compare [this Meta Stack Exchange question](http://meta.stackexchange.com/questions/26011/should-the-markdown-renderer-treat-a-single-line-break-as-br) and debate there.

Thus there are four cases:

1. Text hard wrapped, EOL weakly rendered.
2. Text hard wrapped, EOL strongly rendered.
3. Text soft wrapped, EOL weakly rendered.
4. Text soft wrapped, EOL strongly rendered.

Cases (1) and (4) are desired. But (3) also produces the same result. Meanwhile, (2) fixes text width in output, making typesetting inflexible. For the case of PDF, if the text width is less than page width the margin may be wider than conceived, and if it is more than page width each physical line will take up more than one display line.

Notice however that soft wrap is unaffected in both cases (3) and (4). After all, soft wrap avoids single EOL, in which weak and strong rendition differs.

The practice of hard wrap also violates the principle of Markdown somewhat. The original design of Markdown intends that even the source should be easy to read. But hard wrap isn't something that laypeople (knowing maybe only Microsoft Word) will spontaneously do. It is fair to say hard wrap makes no semantic sense, and is thus artificial.

One user-submitted Wikipedia [guideline](https://en.wikipedia.org/wiki/Wikipedia:Don%27t_use_line_breaks) (retrieved as of Feb. 2017) also raises a similar point against hard wrap. Wiki-markup interpreter also renders EOL weakly, so the guideline is relevant here, although Wiki-markup is different from Markdown. It continues to stress that hard wrap creates a number of difficulties, for example in that they have to be removed before a numbered list or bullet point is added.

## "Halfway Wrap" at Every End of Sentence

A compromised way is to insert EOL at every end of sentence; I shall call this *halfway wrap*. This way, every physical line is a sentence or a clause, which is a meaningful entity. It thus makes sense to go up, go down, cut, or paste an entire line.

But the method of halfway wrap makes ends of apparent lines uneven again, and I have argued above that such estimation plays important role in the creating process.

Still, when writing Markdown, I find it useful to halfway wrap, when I am in the early stage of sketching. Halfway wrap makes it easy to assemble material by cutting or pasting an entire physical line. Afterwards, I remove EOLs between physical lines by visual selecting and `J` when writing in English, or `gJ`, in Chinese.

## Returning to Soft Wrap

After a long contemplation on the matter, I decide to return to the original habit: I will always halfway-wrap TEX sources, but softly-wrap Markdown sources. 

The case for Markdown is different from that of LaTeX. Even though both render EOL weakly, I always see compiled pdf on the facing side, using for example TeXstudio, but view only Markdown source when working on it. Thus I want Markdown sources to visually resemble the output, but that is not necessary as I work on LaTeX sources.

As I see it, the best solution is that Vim show *apparent line numbers*, rather than *physical line numbers*. I hope future Vim will add this as a feature. No wonder, this behavior is contrary to Vim's design—a "line editor". All of Vim's commands deal with the file in a line-by-line basis.

But this does not seem to me completely out of the question. To cater both code-writers and prose-writers, there may even be a setting that toggles line number style between them. Or specification on which is used, may be saved in a "modeline", that is, the first and last few lines of a source file. If in GUI of Vim, like in Microsoft Word, a fairly large, warped arrow appears where a EOL is, hard and soft wrap may be easily distinguished visually, and it will not be confusing to recognize the line number style.

But also arguably, if in a piece of prose the majority of paragraphs are too long to be properly worked with when shown in Vim, these paragraphs are probably too long.

If iTerm's window fits the screen, as I count it, a split window can show at most 74 halfwidth characters such as ASCII characters, or equivalently, 37 fullwidth characters such as Chinese and Chinese punctuations. The height of window can fit 33 lines if none is wrapped. This amounts to 2442 halfwidth or 1221 fullwidth characters. A paragraph as long as half of the capacity of the present window is probably too long. That is at most 610.5 characters or so. I will probably write paragraph as long as this very seldom (unless I wish to write a parody of *In Search of Lost Time*, or achieve the conciousness stream in the very last chapter of *Ulysses*).

That said, it is still unsatisfying that scrolling is not smooth, but a new frame must start with a displayed line of a paragraph (physical line) too. In Microsoft Word or TextEdit for example, this need not be the case, but the first displayed line of in new frame may be any displayed line in any paragraph.

